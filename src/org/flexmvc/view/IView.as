package org.flexmvc.view
{
  import flash.events.IEventDispatcher;

  public interface IView extends IEventDispatcher
  {
    function get isActive():Boolean;
  }
}