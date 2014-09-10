# -*- coding: iso-8859-1 -*-
module MedicalDictionary
  @@dictionary = []

  def self.create(&block)
    builder = MedicalDictionaryBuilder.new
    builder.instance_eval(&block)
    @@dictionary = builder.finalize
  end

  def self.entries
    @@dictionary
  end

  class MedicalDictionaryBuilder
    def initialize
      @entries = []
    end

    def finalize
      @entries
    end

    def entry(&block)
      builder = EntryBuilder.new
      builder.instance_eval(&block)
      @entries.push(builder.finalize)
    end
  end

  class EntryBuilder
    def initialize
      @hash = {}
    end

    def finalize
      @hash
    end

    def method_missing(name, *args, &block)
      @hash[name] = args[0]
    end
  end
end


MedicalDictionary::create do
  entry do
    latijn 'abces'
    ndl 'etterbuil'
  end

  entry do
    latijn 'agens'
    ndl 'werkzame stof'
  end

  entry do
    latijn 'arterieel'
    ndl 'slagaderlijk'
  end

  entry do
    latijn 'antidotum'
    ndl 'tegengif'
  end

  entry do
    latijn 'cardiaal'
    ndl 'met betrekking tot het hart'
  end

  entry do
    latijn 'congenitaal'
    ndl 'aangeboren'
  end

  entry do
    latijn 'contusie'
    ndl 'kneuzing'
  end

  entry do
    latijn 'defecatie'
    ndl 'stoelgang'
  end

  entry do
    latijn 'defici\"entie'
    ndl 'tekort'
  end

  entry do
    latijn 'glucosurie'
    ndl 'suiker in de urine'
  end

  entry do
    latijn 'gastro-enteritis'
    ndl 'buikgriep'
  end

  entry do
    latijn 'inflammatie'
    ndl 'ontsteking'
  end

  entry do
    latijn 'parese'
    ndl 'gedeeltelijke verlamming'
  end

  entry do
    latijn 'stenose'
    ndl 'vernauwing'
  end
end
