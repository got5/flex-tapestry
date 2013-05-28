# flex-tapestry
 
## Introduction
 
This library main goal is to offer the same features the framework tapestry offers to Java developers, but in Flex 4.
 
## Demo
 
See demo project **techforum-flex**: https://github.com/got5/techforum-flex
 
## Features
 
### MVC pattern.
 
 - Low level of coupling between views/controllers/model.
 - Controllers are simple Flex classes and don't extend any core class or to implement any interface.

### Dependency injection in controllers (and later in services/modules):

 - Services injection:

	[Inject]
	public var userService:IUserService;

 - Constants injection:

	[Symbol]
	public var productionMode:String;

 - View components:

	[Component]
	public var txtSearch:TextInput;

### Metadatas to set event listeners in the controller:

 - Initialization methods:

	[SetupRender]
	public function initUser():void {
		...
	}
	
 - Cleanup methods:

	[CleanupRender]
	public function disposeCart():void {
		...
	}

 - Listeners on component events:

	[OnEvent(component='btnSearch', value='click']
	public function search():void {
		...
	}
	
OR, with the naming conventions:

	public function onClickFromBtnSearch():void {
		...
	}


 