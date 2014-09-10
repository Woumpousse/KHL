# -*- coding: iso-8859-1 -*-
require './MedicalDictionary.rb'
require './Exam.rb'
require './Questions.rb'
require './Shared.rb'


$exam = Exam::build do
  hoofding do
    academiejaar '2014--2015'
    datum '10/1/2014'
    beginuur '8.30'
  end

  inhoud do
    richtlijnen

    terminologie do
      latijn_ndl 7
      ndl_latijn 5
    end

    vragen 3
  end
end


puts $exam
