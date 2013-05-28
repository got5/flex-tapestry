/*
Copyright (c) 2006 - 2008  Eric J. Feminella  <eric@ericfeminella.com>
All rights reserved.

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is 
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in 
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR 
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, 
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE 
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER 
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, 
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN 
THE SOFTWARE.

@internal
*/
package org.flexmvc.utils.metadata
{
  import flash.utils.describeType;
  import flash.utils.getQualifiedClassName;
  import flash.utils.getDefinitionByName;
  import flash.utils.Dictionary;
  import mx.collections.ArrayCollection;
  
  /**
   * 
   * <code>MetadataUtils</code> is an all static class which provides 
   * utility operations from which class annotations can be located 
   * and inspected.
   * 
   * <p>
   * <code>MetadataUtils</code> provides a runtime introspective API
   * which can be used to work with custom ActionScript and MXML metadata 
   * annotations
   * </p>
   * 
   */    
  public final class MetadataUtils
  {
    /**
     *
     * Retrieves all defined custom metadata in an object and returns
     * as a <code>Dictionary</code> of name / value pairs
     *  
     * @param  object by which to inspect for custom metadata
     * @return <code>Dictionary</code> of attribute name and values
     * 
     */        
    public static function getMetadata(pObject:Object) : ArrayCollection
    {        
      var metadataNodes:XMLList = getMetadataXML(pObject);
      var n:int = metadataNodes.length();
      
      var annotations:ArrayCollection = new ArrayCollection();
      var map:Dictionary;
      var metadata:XML;
      
      var key:String;
      var value:String;
      
      for (var i:int = 0; i < n; i++)
      {
        metadata = metadataNodes[i];
        map = new Dictionary( true );
        
        for each (var arg:XML in metadata..arg)
        {
          key   = arg.@key;
          value = arg.@value;
          map[ key ] = value;
        }
        annotations.addItem( new Metadata( metadata.@name, map ) );
      }
      return annotations;
    }
    
    /**
     *
     * Retrieves the specific named custom metadata defined in an object 
     * and returns as a <code>Dictionary</code> of name / value pairs
     *  
     * @param  object by which to inspect for custom metadata
     * @param  the specific metadata type to locate
     * @return <code>Dictionary</code> of attribute name and values
     * 
     */        
    public static function getMetadataByName(pObject:Object, pName:String) : Metadata
    {        
      var metadataNodes:XMLList = getMetadataXML( pObject );
      var n:int = metadataNodes.length();
      
      var metadata:Metadata;
      var map:Dictionary = new Dictionary( true );
      
      var key:String;
      var value:String;
      
      for (var i:int = 0; i < n; i++)
      {
        var metadataXML:XML = metadataNodes[i];
        
        if ( metadataXML.@name == pName)
        {
          for each (var arg:XML in metadataXML..arg)
          {
            key   = arg.@key;
            value = arg.@value;
            map[ key ] = value;
          }
          metadata = new Metadata( metadataXML.@name, map );
          break;
        }
      }
      return metadata;
    }
    
    /**
     *
     * Retrieves all custom metadata defined in an object and returns 
     * as a <code>XMLList</code>
     *  
     * @param  object by which to inspect for custom metadata
     * @return <code>XML</code> of attribute name and value nodes
     * 
     */        
    public static function getMetadataXML(pObject:Object) : XMLList
    {
      var xml:XML = describeType(pObject);
      return xml.metadata;
    }
  }
}