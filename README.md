# flex-tapestry
 
## Introduction
 
This library main goal is to offer the same features the framework tapestry offers to Java developers, but in Flex 4.
 
## Demo
 
See demo project *techforum-flex*: https://github.com/got5/techforum-flex
 
## Features
 
### MVC pattern.
 
 - Low level of coupling between views/controllers/model.
 - Controllers are simple Flex classes and don't extend any core class or implement any interface.
 - Thanks to metadatas, your controller do not need to manipulate any component class.

### Dependency injection in controllers (and later in services/modules):

 - **Services injection**:

You can use services, defined in your application module, just by adding a variable of its type in your controller. You do not need to instanciate it, the framework will do it for you. A service in *Flex-tapestry* is composed of an interface and its implementation. Interfaces are always used in controllers, not implementations.
 
	[Inject]
	public var userService:IUserService;

 - **Constants injection**:

*Flex-tapestry* uses several constants (such as production-mode, ...), and you can define your own constants as well in your application module. To use them in your controllers, simply use the metadata *Symbol*.

	[Symbol]
	public var productionMode:String;

 - **View components**:

View components can be used in controllers, by using the metadata *Component*. The variable name has to be the same as the component id.

	[Component]
	public var txtSearch:TextInput;
	
 - **View component properties**:

View component properties can be linked to controller variables. For example, you could define a variable which linked to the property *text* of a *TextInput* component in your view:

	[ComponentProperty(component='txtLogin', property='text')]
	public var login:String;
	
OR, with naming conventions:

	[ComponentProperty]
	public var text_txtLogin:String;

*Note*: If no component is defined, the property will be searched directly in the view component. For example, if you want to get the property *data* of your view:

	[ComponentProperty(property='data')]
	public var currentProduct:Product;
	
### Metadatas to set event listeners in the controller:

 - **Initialization methods**:

Used to call a controller function when the related view is initialized.

	[SetupRender]
	public function initUser():void {
		...
	}
	
 - **Cleanup methods**:

Used to call a controller function when the related view is deactivated.

	[CleanupRender]
	public function disposeCart():void {
		...
	}

 - **Listeners on component events**:

Used to call functions when an event is dispatched by a view component. For example, if you want to listen the *click* event on the button *btnSearch*:

	[OnEvent(component='btnSearch', value='click']
	public function search():void {
		...
	}
	
OR, with the naming conventions:

	public function onClickFromBtnSearch():void {
		...
	}

## Example

This example shows us a view and its controller, used to display a conferences list.

### ConferencesView.mxml

	<?xml version="1.0" encoding="utf-8"?>
	<view:BaseView xmlns:fx="http://ns.adobe.com/mxml/2009"
			xmlns:s="library://ns.adobe.com/flex/spark"
			title="Conférences" xmlns:model="org.got5.model.*" 
			xmlns:service="org.got5.services.*" xmlns:view="org.flexmvc.view.*">
	  
	  <view:navigationContent/>
	  
	  <view:titleContent>
		<s:TextInput id="txtSearch" width="100%"/>
	  </view:titleContent>
	  
	  <view:actionContent>
		<s:Button id="btnSearch" icon="@Embed('../assets/icons/search.png')"/>
	  </view:actionContent>
	  
	  <s:List id="lstConferences" left="0" right="0" top="0" bottom="0" labelField="title">
		<s:itemRenderer>
		  <fx:Component>
			<s:LabelItemRenderer/>
		  </fx:Component>
		</s:itemRenderer>
	  </s:List>
	</view:BaseView>

### ConferencesController.as

	package org.got5.controllers
	{
	  import spark.components.List;
	  
	  import org.flexmvc.view.DestinationViewVO;
	  import org.got5.services.IConferenceService;
	  import org.got5.views.DetailView;
	  
	  /** ConferencesView view controller. */
	  public class ConferencesController
	  {
		/** Conferences service. */
		[Inject]
		public var conferenceService:IConferenceService;
		
		/** Conferences list, from view. */
		[Component]
		public var lstConferences:List;
		
		/** Search field value. */
		[ComponentProperty]
		public var text_txtSearch:String;
		
		/** Handler on clic on btnSearch */
		public function onClickFromBtnSearch():void {
		  lstConferences.dataProvider = conferenceService.findByTitle(text_txtSearch);
		}
		
		/** Handler on change on txtSearch */
		public function onChangeFromTxtSearch():void {
		  lstConferences.dataProvider = conferenceService.findByTitle(text_txtSearch);
		}
		
		/** Handler on change event on list LstConferences. */
		public function onChangeFromLstConferences():DestinationViewVO {
		  return new DestinationViewVO(DetailView, lstConferences.selectedItem);
		}
	  }
	}
	
## How to use Flex-tapestry?

First, add the library *Flex-Tapestry.swc* to your project dependencies.

TODO...