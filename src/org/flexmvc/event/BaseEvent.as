package org.flexmvc.event
{
  import flash.events.Event;
  
  /** Base event, with a data property to register objects. */
  public class BaseEvent extends Event
  {
    /** Used to pass datas among events. */
    protected var _data:Object;
    
    public function get data():Object {
      return _data;
    }
    
    public function BaseEvent(pType:String, pData:Object = null, pBubbles:Boolean=false, pCancelable:Boolean=false) {
      super(pType, pBubbles, pCancelable);
      _data = pData;
    }
  }
}