# Taro 基本概念

Taro 是一套遵循 React 语法规范的多端开发解决方案。 借鉴了 react的状态机 + VUE 指令式模板，将源代码分别编译出在不同端（微信小程序、H5、RN）运行的代码（一次编写，多端运行）。  

Taro 特点
- 不是真正的 react 代码，只是遵从 react 规范的**类 react 代码**
- 厉害的地方是 Taro 的编译器（taro 的核心），将同一套代码编译成不同端

Taro机制：


安装 taro
```
npm install -g @tarojs/cli
taro init {{demoApp}}
```

Taro 目录
```
  ├── config                 配置目录
  |   ├── dev.js             开发时配置
  |   ├── index.js           默认配置
  |   └── prod.js            打包时配置
  ├── src                    源码目录
  |   ├── components         公共组件目录
  |   ├── pages              页面文件目录
  |   |   ├── index          index 页面目录
  |   |   |   ├── banner     页面 index 私有组件
  |   |   |   ├── index.js   index 页面逻辑
  |   |   |   └── index.css  index 页面样式
  |   ├── utils              公共方法库
  |   ├── app.css            项目总通用样式
  |   └── app.js             项目入口文件
  └── package.json

```

index 既可以是组件，也可以是页面。默认是组件，挂载到路由上才是页面

## Taro 生命周期 && state
state 用于组件的 **数据管理** ，与直接通过 `this.varity.proprty` 调用相比，state 可以进行 set 操作和生命周期管理，对数据进行更新  

state 对应几种常用事件用于管理 state ，反映了 state 的生命周期：  
```javascript
state = {
  name: "xiaoming",
  age: "18"
}

componentWillMount() {
  console.log("componentWillMount： 当前页面第一次渲染之前执行 - 然后执行 render - 在组件生命周期内只执行一次")
}

componentDidMount() {
  console.log("componentDidMount ： 当前页面第一次渲染之后执行（render 执行之后）- 在组件生命周期内只执行一次")
  this.setState({
    name: 'seted-xiaoming',
    age: '88'
  },() => console.log("异步立马拿到更新后的值" + this.state.name))
}

componentWillUpdate(nextProps, nextState, nextContext) {
  console.log("componentWillUpdate:（在 setState 之前）state 将要更新")
}

componentDidUpdate(prevProps, prevState, snapshot) {
  console.log("componentDidUpdate: （在 setState 之后）state 数据已经更新完毕")
}

shouldComponentUpdate(nextProps, nextState, nextContext) {
  // 检查此次 setState 是否要进行 render 调用 （一般在多次 setState 调用时使用）
  // 比如 setState 10 次，中间 9 次都不需要刷新render，只需要最后一次刷新 render(否则每次 setState 都刷新 render)，用来提高 render 的性能
  console.log("shouldComponentUpdate : 每次调用 setState 之前都要调用，返回 boolean,默认 false")
  return nextState.name === "seted-xiaoming"
}


componentWillUnmount() {
  console.log("组件被销毁时执行 - 在组件生命周期内只执行一次")
}

componentDidShow() {
  // react 中不存在，小程序中需要
  console.log("componentDidShow: 页面显示时触发")
}

componentDidHide() {
  console.log("页面隐藏时触发")
}
```

更新状态的异步问题：  
- `this.setState({name:"xiaofan"})`后，不能马上获取到更新后的值，需要传一个回调参数获取最新值
- react 中更新状态不一定是异步的，taro 中更新状态一定是异步的

```javascript
componentDidMount() {
  this.setState({
    name: 'seted-xiaoming',
    age: '88'
  },() => console.log("异步立马拿到更新后的值" + this.state.name))
}
```

## Taro Props
父子组件之间的参数传递：  

### 父组件向子组件传引用类型
- 避免空指针：父组件参数设为 undefined 或者不传，不能设为 null
- 子组件默认参数（defaultProps）只在父组件满足上一个条件时生效

父组件：  
```
state = {
  name: "xiaoming",
  age: "18",
  obj:{key:[{summer:'夏天'}]},
  // obj:null (应该为 undefined)
}

render() {

  let {name,obj}=this.state;
  // 父组件传值
  return (
    <View className='index'>
      <Child name={name} obj={obj}></Child>
    </View>
  )
}
```

子组件：
```
class Child extends Component{

  render() {
    let {name,obj} = this.props
    return (<View>
      <Text>我是子节点Child + {name} + {obj.key[0].summer} </Text>
    </View>)
  }
}

// 需要父组件不传该字段，或者父组件定义该字段为 **undefined**
Child.defaultProps={
  obj:{key[{name:"default-summer"}]}
}
export default Child;
```

### 父组件向子组件传方法
小程序传值传方法的时候，但凡在 props 里面存在的函数都 on 开头。  

父组件：
父组件中的 getName 包装成 ontest 的点击事件后，传给子组件
```
getName() {
  console.log("父组件的传入方法")
  return "111"
}

render() {
  let {name,obj}=this.state;

  return (
    <View className='index'>
      <Child name={name} obj={obj} ontest={this.getName}></Child>
    </View>
  )
}
```

子组件：  
```
cl() {
  this.props.ontest();
}

render() {
  let {name, obj} = this.props
  return (<View onClick={this.cl.bind(this)}>
    <Text>我是子节点Child + {name} + {obj.key[0].name} + onTest </Text>
  </View>)
}
```

## Taro 页面跳转


### 路由传参



## 参考资料
[awesome-taro](https://github.com/NervJS/awesome-taro)

掘金小册：[Taro 多端开发实现原理与实战](https://juejin.im/book/5b73a131f265da28065fb1cd?referrer=5ba228f16fb9a05d3251492d)
