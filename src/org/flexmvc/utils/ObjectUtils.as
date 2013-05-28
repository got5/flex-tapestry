package org.flexmvc.utils
{
  import flash.utils.getDefinitionByName;
  
  import avmplus.getQualifiedClassName;

  public class ObjectUtils
  {
    public static function getClass(pObject:Object):Class {
      return Class(getDefinitionByName(getQualifiedClassName(pObject)));
    }
  }
}