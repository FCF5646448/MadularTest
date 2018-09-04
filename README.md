## BT学院模块化之路（实验）

模块化优势: 各模块代码与资源独立使用与维护、独立测试、各模块业务需求利于使用与维护、加快二次启动速度(使用framework的前提下)

### cocoapod 私有库实践

要完成一个pod私有化全过程，需要三个仓库(主项目仓库、pod库仓库、PodDemo项目仓库)、两个项目(主项目、PodDemo项目)

##### 1、在repo下创建私有库(要远程仓库)

cd到cocoapods目录下查看本地的仓库，会发现大概的文件路径是 ~/.cocoapods/repos/master …  这是系统中有使用到cocoapod后，在install pod的时候，会从cocoapod官网下载一份所有的库的podspec文件集合。这些都是共有库的资源。所有项目需要使用pod库的时候会在这里索引，如果search不到，那就需要更新一下你的本地索引了。

因此，创建私有库也是相同道理，就是在repos下创建一个类似master的私有的索引库。所以，首先去个人的远程仓库(比如gitlab)创建一个git仓库。比如是git地址是：https://xx@gitlab.btclass.cn/xx/BTCore.git

然后使用pod命令在Terminal执行：

```
$pod repo add BTCore https://xx@gitlab.btclass.cn/xx/BTCore.git
```

执行成功后，就可以在 ~/.cocoapods/repos/目录下看到BTCore文件夹了。这个就是私有pod库最终的索引。如果和同事合作的话，也同样执行命令创建出一个repo即可。

OK，这一步就是顺便完成了上面提到的pod库仓库。暂且搁置一旁！

##### 2、创建一个新的PodDemo(要远程仓库)

PodDemo就是讲代码打包成pod库工具，另外它本身是一个完整的测试pod库的项目。在将代码打包的前提需要先代码编译通过，所以可以在demo里尽情调试。

使用pod命令创建一个标准的podDemo项目

```
$pod lib create BTCoreDemo
```

创建过程中会提示一些问题，类似：

```
What platform do you want to use?? [iOS/macOS]
What language do you want to use?/ [Swift/ObjC]
Would you like to include a demo application with your library? [Yes/No]
...
```

完成后就会生成一个项目



创建出来的项目的文件结构会包含Example和Pod部分。类似：

```
BTCoreDemo
|——_pods.xcodeproj
|——BTCoreDemo
|  |——Assets                            //放需要pod里的资源文件
|  |——Classes                           //放pod库代码文件
|
|——Example                              //存放完整的项目文件(除pod库之外)
|  |——BTCoreDemo                        //代码文件，比如使用pod库的文件
|  |——BTCoreDemo.xcodeproj
|  |——BTCoreDemo.xcworkspace
|  |——Podfile                           //库使用到的第三方
|  |——Podlock
|  |——Pods                              //依赖的第三方
|  |——Tests 
|
|——BTCoreDemo.podspec                   //最重要的pod配置文件

```



##### 3、将代码移到Demo中，编译成功后，update编译成pod库，并及时将代码更新到远程仓库，注意设置tag

接下来将解耦后的独立代码放到Classes文件中

cd 到Example目录下， 执行

```
$pod update     //完成后会将class里的东西打包成pod库
```

完成之后，用xcode打开工程，会在pods工程下看到Development Pods文件，这里的BTClassDemo就是之后使用的最终的pod库的内容。

但是不是将代码移过来就完成了，首先需要验证pod库，而这第一步就是保证当前Demo工程编译通过。

##### 4、配置podspec（最重要）

在编译通过的前提下，就可以对pod进行一些定制化的操作。

```
Pod::Spec.new do |s|
s.name             = 'BTCoreDemo' #库名称
s.version          = '0.0.1'  #version要和git上的tag进行对应
s.summary          = 'BT学院App中基础文件、公共文件、第三方库等集成框架库'
s.description      = <<-DESC
'BT学院App中基础文件、公共文件、第三方库等集成框架库,gogogogo'
DESC
s.homepage         = 'https://caifan@gitlab.btclass.cn/caifan/BTCoreDemo' #随便一网址
s.license          = { :type => 'MIT', :file => 'LICENSE' }
s.author           = { 'caifan' => '2998000457@qq.com' }
s.source           = { :git => 'https://caifan@gitlab.btclass.cn/caifan/BTCoreDemo.git', :tag => '0.1.96' } #git地址，当前demo的git地址，tag则要和上面的version一样

s.platform = :ios,'9.0' #平台就iOS版本

s.requires_arc = true  #是否支持arc

s.prefix_header_file = 'BTCoreDemo/Classes/prefixHeader.h' #pch头文件，注意：写完prefixHeader.h后，要执行pod update，成功后才会将prefixHeader.h文件的内容copy一份到Support Files下的.pch中。否则项目中使用不了
s.frameworks = 'UIKit', 'AVFoundation','QuartzCore' #对外依赖的库

#subspec: 创建子分支，每个子分支对应一层文件夹，注意：虽然在当前Demo中pod库看似有文件层次，但是当最终生成pod库之后，只会存在子分支的文件层次，各子分支里的所有文件都会被拍扁成一个层级文件
#source_files: 子分支的文件路径，这里有时候会出现找不到文件的情况，所以要实时更新，多个文件用,分割开，**/*表示子文件夹下所有的文件和文件夹
#public_header_files: 子分支的头文件路径。
#dependency: 依赖，子分支之间的依赖、对第三方的依赖
#resource: 资源路径

s.subspec 'Kit' do |kit|
kit.source_files = 'BTCoreDemo/Classes/Kit/**/*', 
kit.public_header_files = 'BTCoreDemo/Classes/Kit/**/*.h'
kit.dependency 'BTCoreDemo/ThirdParty'
end

s.subspec 'ThirdParty' do |thirdparty|
thirdparty.source_files = 'BTCoreDemo/Classes/ThirdParty/**/*'
thirdparty.public_header_files = 'BTCoreDemo/Classes/ThirdParty/**/*.h'
thirdparty.resource = 'BTCoreDemo/Assets/SVProgressHUD.bundle'
end

s.dependency 'Masonry', '~> 1.0.2'

end
```

注意，每次完成后，需要直接pod update，这样pod里的文件才会重新整理更新。

然后给podspec打上tag。注意tag必须和version一致

```
$cd .. //这里是从Example文件夹退到上一层，含有podspec文件的层级
$git tag 0.0.1 
$git push --tag
```

最后，进行验证:

```
$pod lib lint 
```

如果要忽略警告，加上--allow-warnings，如果使用了第三方库，则加上--use-libraries。

如果验证不通过的话，是没法push到repos里的。

而验证通过的前提就是不能有任何error。（这才是整个项目最蛋疼的地方）



##### 5、将编译验证完成的podspec库push到第一步创建的repo私有库中（完成后会看到私有库的远程仓库也会有一份podspec），在podspec文件层级下进行

```
$pod repo push BTCoreDemo BTCoreDemo.podspec --allow-warnings
```

执行完这句后，会在第一步创建的BTCoreDemo下多出一个文件夹，文件夹下是对应版本的podspec。同时第一步创建的远程的git仓库也会多出这些文件。

至此，说明pod库是可用的了。

##### 6、检测是否能search到私有库 

```
$pod search BTCoreDemo
```

如果搜索不到就先执行：

```
$rm ~/Library/Caches/CocoaPods/search_index.json 
```

##### 7、将pod成功的私有库添加到原来的项目中

编译原来项目的Podfile，将BTCoreDemo添加进去。

注意，podfile中需要把共有和私有的两个地址都加上。

```
source 'https://github.com/CocoaPods/Specs.git'  # 官方库
source 'https://xx@gitlab.btclass.cn/xx/BTCore.git' #私有库
```

##### 8、码过留坑

这里整理一下遇到的问题及解决的方案：

###### 1、pod lib lint 中碰到的各种error和warn

ERROR | [iOS] file patterns: The `resource_bundles` pattern for `SVProgressHUD` did not match any file. 

分析：目前总结出现这个问题的原因一般为：1、没有打tag；2、tag与version不一致；3、各种路径错误（这个有可能是它本身会抽，有时候提示路径问题，但是改完倒腾回来就又有用了，也可能是没有掌握到精髓）

--allow-warnings 忽略警告的验证过程

###### 2、资源文件问题bundle
resource和resource_bundles的差异，参考[简书](https://juejin.im/post/5a77fb8df265da4e99576702)

###### 3、subspec分支问题、文件夹问题

​目前所知文件夹是没法做层级的，只有分子分支，每个子分支会是一个文件夹。
​
​###### 4、swift混编问题
​
​无论swift文件在哪里，使用#import <XX/XX-swift.h>导入swift桥接文件
​
​这里的XX指的是pod包的名称，其次要注意的是swift类应该用@objc标注声明
​
​###### 5、编译不通过
​
​Returned an unsuccessful exit code. You can use `--verbose` for more information.
​
​打成pod包的前提就是编译一定要通过，所以这个没有捷径可走
​
​###### 6、库循环依赖问题
​There is a circular dependency between BTCore/ThirdParty and BTCore/Kit 
​
​出现这个问题的原因是由于pod库里面有子分支，每个子分支也是一个单独的pod库，所以分支之间文件的引用如果不要pch的话，就需要使用dependency做依赖。因为子分支有可能会有相互引用到对方文件的问题，所以如果使用dependency，就有可能会相互依赖的问题，最后导致circular dependency。
​
​目前的解决问题就是子分支也解耦。如果子分支无法解耦，那就使用pch全局引入需要用到的文件。不过这也导致一个问题，那就是子分支就没法单独做pod使用了。所以最好的解决方案是解耦。
​
​###### 7、pch使用
​
​​语法： prefix_header_file: 预编译头文件路径，将该文件的内容插入到Pod的pch文件内 
​​
​​​1:ERROR | [iOS] unknown: Encountered an unknown error (No such file or directory @ rb_sysopen - /private/var/folders/n2/0fyx87s539j43pqj65tnwccc0000gn/T/CocoaPods-Lint-20180829-11315-7jhkz-BTCore/Pods/BTCore/BTCore/Classes/prefixHeader.pch) during validation.
​​​
​​​​目前得出的结论，pch除了能在PodDemo中使用，在pod库中，完全就是绊脚石般的存在
​​​​
​​​​###### 8、压死骆驼的最后一根稻草 
​​​​
​​​​​xcodebuild: Returned an unsuccessful exit code. You can use `--verbose` for more information.
​​​​​
​​​​​​这他妈不知道是什么原因呀
​​​​​​
​​​​​​​初步估计是因为pch的问题。查看了很多第三方pod，发现压根不使用pch这玩意。而且每次error后的note也都是提示pch里的import文件not found。
​​​​​​​
​​​​​​​​所以，首先。准备好子分支之间的拆分。不能出现循环依赖的问题，不能相互import，总之pch没有作用。
​​​​​​​​
​​​​​​​​掉进坑里，挣扎出不来了！！
​​​​​​​​
​​​​​​​​pod lib lint --allow-warnings 忽略警告的验证过程
​​​​​​​​
​​​​​​​​pod repo push mySpec myLibrary.podspec —allow-warnings  
​​​​​​​​
​​​​​​​​
​​​​​​​​
​​​​​​​​##### 9、pod存在的问题：
​​​​​​​​
​​​​​​​​###### 1、文件夹问题
​​​​​​​​
​​​​​​​​​pod暴露的东西只存在public_header_files中，而且目前没有找到文件夹区分层次关系的问题。
​​​​​​​​​
​​​​​​​​​###### 2、生成的pod与实际能够使用的pod有区别
​​​​​​​​​
​​​​​​​​​​生成的pod在demo中和实际验证之后pod update下来的pod文件层次是不一样的，感觉非常不友好。而且及时生成了pod，验证也存在很多问题，且问题难以定位。
​​​​​​​​​​
​​​​​​​​​​
​​​​​​​​​​[cocoapod创建私有库](http://blog.wtlucky.com/blog/2015/02/26/create-private-podspec/) 
​​​​​​​​​​
​​​​​​​​​​[podspec资源文件的引用](https://juejin.im/post/5a77fb8df265da4e99576702) 
​​​​​​​​​​
​​​​​​​​​​[写podspec](https://segmentfault.com/a/1190000012269307) 
​​​​​​​​​​
​​​​​​​​​​[cocoapod guide](https://guides.cocoapods.org/) 
​​​​​​​​​​
​​​​​​​​​​
​​​​​​​​​​
​​​​​​​​​​## cocoa touch framework实践
​​​​​​​​​​##### 1、什么是动态库
​​​​​​​​​​库Library是一段编译好的二进制文件，如果想自己的实现代码不暴露给别人，就可以使用库的形式进行封装，编译的时候只需要link就好。链接又存在静态链接和动态链接两种方式，于是便产生了静态库和动态库。
​​​​​​​​​​
​​​​​​​​​​静态库即.a文件(windows的lib)，静态库编译的时候会将二进制文件直接copy进目标程序中，之后将随着一起加载，所以也就导致目标文件太大的问题。
​​​​​​​​​​
​​​​​​​​​​动态库则是.tab、.dylib文件，与动态库不同的是编译的时候不会被copy，而是只在目标文件中存一份动态库的引用。它不会导致体积问题，但是动态载入的时候也会导致一些性能损耗。
​​​​​​​​​​
​​​​​​​​​​Framework是一直打包方式，它将二进制文件、头文件、资源文件打包到一起。
​​​​​​​​​​
​​​​​​​​​​##### 、创建自己的framework
​​​​​​​​​​###### 1、创建framework
​​​​​​​​​​打开xcode 选择创建 cocoa touch framework 就可以了。
​​​​​​​​​​这里有几点注意：
​​​​​​​​​​* 创建动态库需要去setting中将mach-Type改成Dynamic Library
​​​​​​​​​​* 如果要引入其他的framework，需要去setting中将**Allow non-modular includes in Framework Modules** 改成YES。
​​​​​​​​​​* 如果有使用swift，需要去设置好swift的版本
​​​​​​​​​​* framework不允许存在其他的framework
​​​​​​​​​​* 如果是Swift&OC混编的framework，则要把swift中使用到的OC头文件在Header中放到public中，因为framework不支持bridge
​​​​​​​​​​* 将要对外的头文件也放到Header的public中
​​​​​​​​​​* 把需要添加的依赖库加上，尤其是使用了第三方，比如wechatsdk的
​​​​​​​​​​
​​​​​​​​​​###### 2、使用framework
​​​​​​​​​​* 将framework拖进来后，将framework copy一份。确保Embedded Binaries存在你的framework
​​​​​​​​​​* 如果framework中有swift文件而当前工程还没有swift文件，则需要先创建一个swift bridge。
​​​​​​​​​​* 将原来framework依赖到的第三方也要pod进来
​​​​​​​​​​
​​​​​​​​​​###### 3、framework使用其他第三方framework
​​​​​​​​​​* 苹果禁止在Dynamic Framework中使用Framework。比如alipay。而pod的framework也只是将引用打包进去。所以这种依赖要在自己的framework的readme中注释清楚。
​​​​​​​​​​
​​​​​​​​​​###### 4、给framework添加armv7s架构
​​​​​​​​​​模拟器对应的内核框架中，32位处理器对应的是i386，64位处理器对应的是x86_64
​​​​​​​​​​
​​​​​​​​​​真机内核情况如下：
​​​​​​​​​​
​​​​​​​​​​armv7: iPhone4 以下机型、iPad mini、iPod、iPad3以下
​​​​​​​​​​
​​​​​​​​​​armv7s: iPhone5、iPhone5C、iPad4
​​​​​​​​​​
​​​​​​​​​​arm64: iPhone5s以上、iPad air、iPad mini2
​​​​​​​​​​
​​​​​​​​​​在Architectures添加完armv7s后，一直报error: Invalid bitcode signature ;  clang: error: linker command failed with exit code 1 (use -v to see invocation)。
​​​​​​​​​​
​​​​​​​​​​解决的步骤就是：将DeviceData删掉，然后给所有pod导进来的framework添加上armv7s。重新编译就OK了。
​​​​​​​​​​
​​​​​​​​​​##### 3、整合framework，将模拟器和真机的debug、release包整合到一起
​​​​​​​​​​首先将每一次build都只有一个包产生。而要产生release和debug包得分别在release和debug下进行编译，这样在Debug-iphoneos下两个文件夹才有对应的包。然后在将Build Active Architecture Only设置成NO(包括pod库里的target)，这样才能在切换真机与模拟器的同时编译出对应的iphoneos和iphonesimulator包
​​​​​​​​​​
​​​​​​​​​​使用 [命令行打包](http://msching.github.io/blog/2014/05/05/custom-framework-merging/)  
​​​​​​​​​​
​​​​​​​​​​
​​​​​​​​​​```
​​​​​​​​​​//查看包的内核架构有哪些：
​​​​​​​​​​$lipo -info /Users/fengcaifan/Library/Developer/Xcode/DerivedData/BTCore-foehvkpuvmgklxekqrhynchxldkr/Build/Products/Release-iphoneos/BTCore.framework/BTCore 
​​​​​​​​​​// armv7 armv7s arm64 
​​​​​​​​​​```
​​​​​​​​​​
​​​​​​​​​​```
​​​​​​​​​​//将Debug环境下的真机和模拟器一同打包：
​​​​​​​​​​$cd 到包目录
​​​​​​​​​​
​​​​​​​​​​$lipo -create Debug-iphoneos/BTCore.framework/BTCore Debug-iphonesimulator/BTCore.framework/BTCore -output BTCoreDebugFramework //结束后会产生一个包
​​​​​​​​​​
​​​​​​​​​​$lipo -info BTCoreDebugFramework //查看包内容 Architectures in the fat file: BTCoreDebugFramework are: i386 x86_64 armv7 armv7s arm64
​​​​​​​​​​
​​​​​​​​​​//这里执行完是整合出一个可执行文件，还并不是.framework。所以只需将这个可执行文件将上述任意framework里的可执行文件替换掉就可以使用了。
​​​​​​​​​​```
​​​​​​​​​​
​​​​​​​​​​* 这里碰到一个问题，使用cocoapod的库，使用Aggregate 脚本打包一直报swift找不到pod库。
​​​​​​​​​​
​​​​​​​​​​##### 4、framework结合cocoapod的实践
​​​​​​​​​​​framework中使用cocoapod是将需要依赖的第三方库以pod的形式导入进来。但是要注意的一点就是framework如果是swift项目或者保存swift混编，则需要将pod库打包成framework。
​​​​​​​​​​​
​​​​​​​​​​​##### 5、framework结合carthage的实践
​​​​​​​​​​​​carthage和cocoapod一样是一个三方库管理工具, [carthage和cocoapod的区别](http://www.hangge.com/blog/cache/detail_1359.html)  。因为carthage只生成framework，所以更符合我们这种混编的framework的需求。因为它目前流行于swift第三方库中，对于一些老的OC库还不支持，比如Masonry。所以这里按自己需求使用。
​​​​​​​​​​​​
​​​​​​​​​​​​##### 6、上线之前，最好将framework进行拆包，只上传Release真机包到app store。
​​​​​​​​​​​​拆包，将需要的架构拆出来，整合成新的架构
​​​​​​​​​​​​
​​​​​​​​​​​​```
​​​​​​​​​​​​$ lipo BTCore -thin armv7 -output BTCoreV7 //将BTCore中armv7架构拆出来，生成一个叫BTCoreV7可执行文件
​​​​​​​​​​​​$ lipo BTCore -thin arm64 -output BTCore64   //将BTCore中arm64架构拆出来，生成一个叫BTCore64可执行文件
​​​​​​​​​​​​$ lipo -create BTCoreV7 BTCore64 -output BTCoreV764 //将BTCoreV7 BTCore64整合成一个新的BTCoreV764
​​​​​​​​​​​​```
​​​​​​​​​​​​
​​​​​​​​​​​​
​​​​​​​​​​​​
​​​​​​​​​​​​##### 7、码过留坑
​​​​​​​​​​​​###### 1、framework中OC与Swift类的相互调用(无法使用bridging导致的锅)
​​​​​​​​​​​​
​​​​​​​​​​​​​因为framework无法使用bridging，所以swift中使用到的OC的类，必须得放到public中。然后在xx.h (xx是项目名称)中按说明的格式import进来
​​​​​​​​​​​​​
​​​​​​​​​​​​​###### 2、framework里的swift使用pod里的OC类(无法使用bridging导致的锅)
​​​​​​​​​​​​​​因为framework无法使用bridging，所以pod里的oc类无法通过上述方式导入，而应该通过将第三方pod生成framework导入，即在podfile中添加 use_framework!。但是要注意的是，此时生成的framework在xcode中还显示红色，得把mach-type和Allow non-modular..设置好，build之后才能在pod文件夹找到framework。
​​​​​​​​​​​​​​
​​​​​​​​​​​​​​###### 3、dyld: Library not loaded: @rpath/libswiftCore.dylib (Demo里没有swift bridge导致的锅)
​​​​​​​​​​​​​​说明framework里有swift类，但是demo中没有创建swift bridge。所以去创建一个就好了
​​​​​​​​​​​​​​
​​​​​​​​​​​​​​######4、Reason: image not found
​​​​​​​​​​​​​​embedded没有framework导致的。
​​​​​​​​​​​​​​
​​​​​​​​​​​​​​###### 5、无法使用framework里的类(request改成optional导致的锅)
​​​​​​​​​​​​​​实际上，request是不允许改成optional的，否则运行时是没法使用framework里的类，正确的做法就是去查看framework的allow non_module是否配置成功。然后确保demo中embedded中是否存在自己的framework。
​​​​​​​​​​​​​​
​​​​​​​​​​​​​​##### 8、framework存在的问题
​​​​​​​​​​​​​​* 因为framework只暴露了头文件，所以没法对其进行调试。这会是一个很蛋疼的问题
​​​​​​​​​​​​​​
​​​​​​​​​​​​​​
​​​​​​​​​​​​​​##### 9、后续优化
​​​​​​​​​​​​​​* 1、优化API设计
​​​​​​​​​​​​​​* 2、给每个子模块创建Demo，添加测试代码
​​​​​​​​​​​​​​* 4、在每个子模块中写登录脚本实现登录
​​​​​​​​​​​​​​* 5、framework自动正好到主项目的工具链
​​​​​​​​​​​​​​
​​​​​​​​​​​​​​
​​​​​​​​​​​​​​[喵神的打造让人愉快的框架](https://onevcat.com/2016/01/create-framework/)
​​​​​​​​​​​​​​[小鱼的dump砸壳](http://zhoulingyu.com/2016/08/30/iOS%E6%94%BB%E9%98%B2%E2%80%94%E2%80%94%EF%BC%88%E5%9B%9B%EF%BC%89class-dump%20%E4%B8%8E%20Dumpdecrypted%20%E4%BD%BF%E7%94%A8/)
​​​​​​​​​​​​​​[framework中使用cocoapod](https://www.jianshu.com/p/8650864c6c15)
​​​​​​​​​​​​​​[豆瓣模块化](http://lincode.github.io/Modularity)
​​​​​​​​​​​​​​[组件化——动态库实践](http://www.cocoachina.com/ios/20170427/19136.html)
​​​​​​​​​​​​​​
​​​​​​​​​​​​​​
​​​​​​​​​​​​​​

