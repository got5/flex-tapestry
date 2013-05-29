package org.flexmvc.utils
{
  import mx.core.UIComponent;
  
  import spark.components.View;
  
  /** Utilities methods about containers and components. */
  public class ContainerUtils
  {
    /** Returns a child of id pChildId from parent pContainer. */
    public static function getChildById(pContainer:UIComponent, pChildId:String, pCaseSensitive:Boolean = false):UIComponent {
      if (pContainer) {
        if (pContainer.id && ((pCaseSensitive && pContainer.id == pChildId) || (!pCaseSensitive && pContainer.id.toLowerCase() == pChildId.toLowerCase()))) {
          return pContainer;
        }
        
        if (pContainer.numChildren > 0) {
          var length:int = pContainer.numChildren;
          var child:UIComponent;
          var subChild:UIComponent;
          for (var index:int = 0; index < length; index++) {
            child = pContainer.getChildAt(index) as UIComponent;
            if (child) {
              subChild = getChildById(child, pChildId, pCaseSensitive);
              if (subChild) {
                return subChild;
              }
            }
          }
        }
        
        //Fixes, because components can have children outside the classic getChild... Thanks Flex.
        if (pContainer is View) {
          var view:View = pContainer as View;
          var foundChild:UIComponent;
          //View navigationContent
          if (view.navigationContent && view.navigationContent.length > 0) {
            for each (var navChild:UIComponent in view.navigationContent) {
              foundChild = getChildById(navChild, pChildId, pCaseSensitive);
              if (foundChild) {
                return foundChild;
              }
            }
          }
          //View actionContent
          if (view.actionContent && view.actionContent.length > 0) {
            for each (var actionChild:UIComponent in view.actionContent) {
              foundChild = getChildById(actionChild, pChildId, pCaseSensitive);
              if (foundChild) {
                return foundChild;
              }
            }
          }
          //View titleContent
          if (view.titleContent && view.titleContent.length > 0) {
            for each (var titleChild:UIComponent in view.titleContent) {
              foundChild = getChildById(titleChild as UIComponent, pChildId, pCaseSensitive);
              if (foundChild) {
                return foundChild;
              }
            }
          }
        }
      }
      return null;
    }
  }
}