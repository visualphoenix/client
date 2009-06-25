#!/usr/bin/ruby -w

#
# Test the Version class
#

require 'test/unit'
$: << '..'
require 'versiontype'

class VersionTests < Test::Unit::TestCase
  
  def test_version
    assert(Version.new('1') == Version.new('1'))
    assert(Version.new('1') == Version.new('1.0'))
    assert(Version.new('.5') == Version.new('0.5'))
    assert(Version.new('5.') == Version.new('5'))
    assert(Version.new('5.') == Version.new('5.0'))
    
    assert(Version.new('1') >= Version.new('1'))
    assert(Version.new('1') >= Version.new('1.0'))
    
    assert(Version.new('1') < Version.new('1.1'))
    assert(Version.new('1.01') < Version.new('1.1'))
    assert(Version.new('1.009') < Version.new('1.010'))
    assert(Version.new('1') < Version.new('2'))
    assert(Version.new('1.0') < Version.new('2.0'))
    assert(Version.new('1.0') < Version.new('2.0.0'))
    assert(Version.new('2.5') < Version.new('2.5.1'))
    assert(Version.new('2.5.1') < Version.new('2.6'))
    assert(Version.new('2.9') < Version.new('2.10'))
    
    assert(Version.new('1') != Version.new('2'))
    assert(Version.new('1') != Version.new('2.0'))
    assert(Version.new('1..0') != Version.new('1'))
    assert(Version.new('1..0') != Version.new('1.0'))
    assert(Version.new('1..0') != Version.new('1.0.0'))
    
    assert(Version.new('.5') < Version.new('5.0'))
    assert(Version.new('.5') < Version.new('5'))
    
    assert(Version.new('a') < Version.new('b'))
    assert(Version.new('1.0a') < Version.new('1.0b'))
    assert(Version.new('1.0.a') < Version.new('1.0.b'))
    assert(Version.new('1.9a') < Version.new('1.10b'))
    assert(Version.new('1.9a.2') != Version.new('1.9.a.2'))
    assert(Version.new('1.9a.2') < Version.new('1.10b.1'))
    
    # Different sized sub-arrays [3, [0, 'beta', 3]] vs [3, [0, '0', 0]]
    result = Version.new('3.0beta3') < Version.new('3')
    result = Version.new('3.0beta3') < Version.new('3.0')
    
    # The result of this comparison is meaningless, we just want to
    # verify that it doesn't throw an exception
    assert(Version.new('1.a') != Version.new('1.1'))
  end
end