package org.flexmvc.view
{
  import flash.events.Event;
  
  import spark.components.View;
  import spark.events.ViewNavigatorEvent;
  
  public class BaseView extends View implements IView {
    
    public function BaseView() {
      super();
    }
    
    override protected function createChildren():void {
      super.createChildren();
      
      addEventListener(ViewNavigatorEvent.VIEW_ACTIVATE, onActivate);
      addEventListener(ViewNavigatorEvent.VIEW_DEACTIVATE, onDeactivate);
    }
    
    override public function dispatchEvent(pEvent:Event):Boolean {
      trace('[DEBUG] View ' + this + ' has dispatched event : ' + pEvent.type);
      return super.dispatchEvent(pEvent);
    }
    
    protected function onActivate(pEvent:ViewNavigatorEvent):void {
      ViewManager.activateView(this);
    }
    
    protected function onDeactivate(pEvent:ViewNavigatorEvent):void {
      ViewManager.deactivateView(this);
    }
    
    private function deleteListeners():void {
      removeEventListener(ViewNavigatorEvent.VIEW_ACTIVATE, onActivate);
      removeEventListener(ViewNavigatorEvent.VIEW_DEACTIVATE, onDeactivate);
    }
  }
}