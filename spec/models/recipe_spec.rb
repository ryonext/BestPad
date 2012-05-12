#encoding: utf-8
require 'spec_helper'

describe Recipe do
  describe 'expand_uri' do
    context 'no shorten' do
      it 'get origial uri' do
        expand_uri = Recipe.getExpandUri('http://www.yahoo.co.jp/')
        expand_uri.should == 'http://www.yahoo.co.jp/'
      end
    end
    context 'one shorten' do
      it 'get original uri' do
        expand_uri = Recipe.getExpandUri('http://bit.ly/INPsu')
        expand_uri.should == 'http://www.yahoo.co.jp/'
      end
    end
    context 'two shorten' do
      it 'get original uri' do
        expand_uri =  Recipe.getExpandUri('http://seo-air.jp/MA71ue')
        expand_uri.should == 'http://www.yahoo.co.jp/'
      end
    end
    context 'no arg' do
      it 'get nil' do
        expand_uri = Recipe.getExpandUri(nil)
        expand_uri.should be_nil
      end
    end
    context '404 uri' do
      it 'get nil' do
        expand_uri = Recipe.getExpandUri('http://wwwwww.yahoo.co.jp/')
        expand_uri.should be_nil
      end
    end
    context 'not uri' do
      it 'get nil' do
        Recipe.getExpandUri('urlじゃないよねこれ').should be_nil
      end
    end
    context 'integer' do
      it 'get nil' do
        Recipe.getExpandUri(12345).should be_nil
      end
    end
  end

  describe 'collect' do
    context '1.1' do
      it 'not error' do
        Recipe.collect(1,1)
      end
    end
  end

  context '' do
    describe 'format_uri' do
      context ':' do
        it ': is removed' do
          Recipe.format_uri('http://www.yahoo.co.jp/:').should == 'http://www.yahoo.co.jp/'
        end
      end
      context ':::::' do
        it ':::: is removed' do
          Recipe.format_uri('http://www.yahoo.co.jp/:::::').should == 'http://www.yahoo.co.jp/'
        end
      end
      context '@' do
        it '@ is removed' do
          Recipe.format_uri('http://www.yahoo.co.jp/@').should == 'http://www.yahoo.co.jp/'
        end
      end
      context '@@@@@' do
        it '@@@@@ is removed' do
          Recipe.format_uri('http://www.yahoo.co.jp/@@@@@').should == 'http://www.yahoo.co.jp/'
        end
      end
      context '.' do
        it '. is removed' do
          Recipe.format_uri('http://www.yahoo.co.jp/.').should == 'http://www.yahoo.co.jp/'
        end
      end
      context '.....' do
        it '..... is removed' do
          Recipe.format_uri('http://www.yahoo.co.jp/.....').should == 'http://www.yahoo.co.jp/'
        end
      end
      context '(' do
        it '( is removed' do
          Recipe.format_uri('http://www.yahoo.co.jp/(').should == 'http://www.yahoo.co.jp/'
        end
      end
      context '(((((' do
        it '((((( is removed' do
          Recipe.format_uri('http://www.yahoo.co.jp/(((((').should == 'http://www.yahoo.co.jp/'
        end
      end
      context ')' do
        it ') is removed' do
          Recipe.format_uri('http://www.yahoo.co.jp/)').should == 'http://www.yahoo.co.jp/'
        end
      end
      context ')))))' do
        it '))))) is removed' do
          Recipe.format_uri('http://www.yahoo.co.jp/)))))').should == 'http://www.yahoo.co.jp/'
        end
      end
      context '?' do
        it '? is removed' do
          Recipe.format_uri('http://www.yahoo.co.jp/?').should == 'http://www.yahoo.co.jp/'
        end
      end
      context '?aaabbb' do
        it '? and later character is removed' do
          Recipe.format_uri('http://www.yahoo.co.jp/?aaabbb').should == 'http://www.yahoo.co.jp/'
        end
      end
      context '@.:is contained but not final character' do
        it 'characters not removed' do
          Recipe.format_uri('http://aaa@bbbtest/')
        end
      end
    end
  end
end
