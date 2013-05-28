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
  import flash.utils.Dictionary;
  
  /**
   * 
   * <code>Metadata</code> provides a strongly typed implementation
   * of a metadata entry.
   * 
   */    
  public class Metadata
  {
    /**
     *
     * @private
     *  
     * Defines the <code>Metadata</code> entry name
     * 
     */        
    private var _name:String;
    
    /**
     *
     * @private
     * 
     * Defines the <code>Metadata</code> entry arguments
     *  
     */    
    private var _arguments:Dictionary;
    
    /**
     *
     * <code>Metadata</code> constructor accepts a metadata entry
     * name and arguments
     *  
     * @param name of the metadata entry
     * @param arguments defined for the metadata entry
     * 
     */        
    public function Metadata(name:String, arguments:Dictionary)
    {
      this._name = name;
      this._arguments = arguments;
    }
    
    /**
     *
     * Retrieves the name specified for the <code>Metadata</code>
     * entry instance
     *  
     * @return <code>Metadata</code> entry name
     * 
     */        
    public function get name() : String
    {
      return _name;
    }
    
    /**
     *
     * Retrieves the arguments specified for the <code>Metadata</code>
     * entry instance. 
     *  
     * <p>
     * <code>Metadata.arguments</code> are defined as name / values
     * pairs of metadata keys and their associated values
     * </p>
     * 
     * @return <code>Metadata</code> entry name
     * 
     */    
    public function get arguments() : Dictionary
    {
      return _arguments;
    }
  }
}