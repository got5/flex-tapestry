package org.flexmvc.view
{
  import flash.events.Event;
  import flash.events.UncaughtErrorEvent;
  
  import mx.events.FlexEvent;
  
  import org.flexmvc.constants.SymbolConstants;
  import org.flexmvc.core.ApplicationManager;
  import org.flexmvc.core.ModuleError;
  
  import spark.components.ViewNavigatorApplication;

  public class BaseApplication extends ViewNavigatorApplication {
    
    /** Used to define the application module. */
    private var _moduleClass:Class;
    
    public function set moduleClass(pClass:Class):void {
      _moduleClass = pClass;
    }
    
    public function get moduleClass():Class {
      return _moduleClass;
    }
    
    override protected function createChildren():void {
      //Sets the default view of the application.
      if (!firstView) {
        firstView = ApplicationManager.getSymbolConstantValue(SymbolConstants.FIRST_VIEW) as Class;
      }
      if (!firstView) {
        throw new ViewError("No default view has been defined for your application. Sets the symbol constant FIRST_VIEW in your module.");
      }
      
      super.createChildren();
      
      //Makes sure a module class has been defined in the application.
      if (_moduleClass == null) {
        throw new ModuleError("The parameter 'moduleClass' is mandatory in your main application.");
      }
      
      addEventListener(FlexEvent.APPLICATION_COMPLETE, onApplicationComplete);
    }
    
    private function onApplicationComplete(pEvent:FlexEvent):void {
      removeEventListener(FlexEvent.APPLICATION_COMPLETE, onApplicationComplete);
      
      if (loaderInfo) {
        //Listens to all exceptions.
        loaderInfo.uncaughtErrorEvents.addEventListener(UncaughtErrorEvent.UNCAUGHT_ERROR, uncaughtErrorHandler);
      }
    }
    
    /** Handler on every uncaught error dispatched by the application. */
    private function uncaughtErrorHandler(pEvent:UncaughtErrorEvent):void {
      //TODO
    }
    
    override public function dispatchEvent(pEvent:Event):Boolean {
      return super.dispatchEvent(pEvent);
    }
  }
}