package org.flexmvc.utils
{
  import flash.utils.Dictionary;
  
  /** Implémentation de la Hashmap, un dictionnaire doté d'une surcouche de fonctionnalités. */
  public class HashMap
  {
    /** Dictionnaire de base. */
    private var _dico:Dictionary;
    
    /** Retourne le nombre d'éléments de la Map. */
    public function get length():int
    {
      var nbElements:int = 0;
      for (var key:*in this._dico)
      {
        nbElements++;
      }
      return nbElements;
    }
    
    /** Constructeur. */
    public function HashMap(pWeakReference:Boolean = true)
    {
      this._dico = new Dictionary(pWeakReference)
    }
    
    /**
     * Ajout d'un élément dans la Map.
     *
     * @pKey Clé de l'élément à ajouter.
     * @pValue Valeur à ajouter.
     */
    public function put(pKey:*, pValue:*):void
    {
      this._dico[pKey] = pValue;
    }
    
    /**
     * Retourne true si la map détient un élément de clé <i>pKey</i>, false sinon.
     *
     * @param pKey Clé à rechercher au sein de la map.
     * @return Boolean
     */
    public function hasKey(pKey:*):Boolean
    {
      return (this._dico[pKey] != undefined);
    }
    
    /**
     * Retourne true si la map détient une valeur égale à <i>pValue</i>, false sinon.
     *
     * @param pValue Valeur à rechercher au sein de la map.
     * @return Boolean
     */
    public function hasValue(pValue:*):Boolean
    {
      for (var key:*in this._dico)
      {
        if (this._dico[key] == pValue)
        {
          return true;
        }
      }
      return false;
    }
    
    /**
     * Retourne la valeur de l'élément de clé <i>pKey</i>.
     *
     * @param pKey Clé de l'élément.
     * @param * Valeur de l'élément.
     */
    public function getValue(pKey:*):*
    {
      return this._dico[pKey];
    }
    
    /**
     * Retourne la clé de l'élément de la map de valeur <i>pValue</i>.
     *
     * @param pValue Valeur à rechercher au sein de la map.
     * @return * Clé de l'élément de valeur <i>pValue</i>.
     */
    public function getKey(pValue:*):*
    {
      for (var key:*in this._dico)
      {
        if (this._dico[key] == pValue)
        {
          return key;
        }
      }
      return null;
    }
    
    /**
     * Retourne un Array avec les clés de la map.
     *
     * @return Array
     */
    public function get keys():Array
    {
      var arrKeys:Array = new Array();
      for (var key:*in this._dico)
      {
        arrKeys.push(key);
      }
      return arrKeys;
    }
    
    /**
     * Retourne un Array avec les valeurs de la map.
     *
     * @return Array
     */
    public function get values():Array
    {
      var arrValues:Array = new Array();
      for (var key:*in this._dico)
      {
        arrValues.push(this._dico[key]);
      }
      return arrValues;
    }
    
    /**
     * Suppression de l'élément de clé <i>pKey</i>.
     *
     * @param pKey Clé de l'élément à supprimer.
     * @return * L'objet supprimé.
     */
    public function remove(pKey:*):*
    {
      var value:* = this._dico[pKey];
      delete this._dico[pKey];
      return value;
    }
    
    /**
     * Suppression de tous les éléments de la Map.
     */
    public function removeAll():void
    {
      for (var key:*in this._dico)
      {
        delete this._dico[key];
      }
    }
  }
}