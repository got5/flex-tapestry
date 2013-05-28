package org.flexmvc.view
{
  import spark.transitions.ViewTransitionBase;
  
  /** Return type of controller functions. */
  public class DestinationViewVO {
    
    private var _viewClass:Class;
    
    public function get viewClass():Class {
      return _viewClass;
    }
    
    private var _data:Object;
    
    public function get data():Object {
      return _data;
    }
    
    private var _context:Object;
    
    public function get context():Object {
      return _context;
    }
    
    private var _transition:ViewTransitionBase;
    
    public function get transition():ViewTransitionBase {
      return _transition;
    }
    
    public function DestinationViewVO(pViewClass:Class, pData:Object = null, pContext:Object = null, pTransition:ViewTransitionBase = null) {
      _viewClass = pViewClass;
      _data = pData;
      _context = pContext;
      _transition = pTransition;
    }
  }
}