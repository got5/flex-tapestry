package org.flexmvc.utils
{
  import flash.display.DisplayObjectContainer;
  
  import mx.core.UIComponent;
  
  /** Utilities methods about containers and components. */
  public class ContainerUtils
  {
    /** Returns a child of id pChildId from parent pContainer, recursivelly if needed. */
    public static function getChildById(pContainer:UIComponent, pChildId:String, pRecursive:Boolean = true, pCaseSensitive:Boolean = false):UIComponent {
      if (pContainer && pContainer.numChildren > 0) {
        var length:int = pContainer.numChildren;
        var child:UIComponent;
        var subChild:UIComponent;
        for (var index:int = 0; index < length; index++) {
          child = pContainer.getChildAt(index) as UIComponent;
          
          if (child) {
            if (child.id && ((pCaseSensitive && child.id == pChildId) || (!pCaseSensitive && child.id.toLowerCase() == pChildId.toLowerCase()))) {
              return child;
            }
            
            if (pRecursive && child is DisplayObjectContainer) {
              subChild = getChildById(child, pChildId, true, pCaseSensitive);
              if (subChild) {
                return subChild;
              }
            }
          }
        }
      }
      return null;
    }
  }
}