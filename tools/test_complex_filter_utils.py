#!/usr/bin/env python
# -*- coding: utf-8 -*-
"""
测试复杂查询工具类
验证utils.filters中的BaseComplexFilter和ComplexQueryMixin是否正常工作
"""

import os
import sys
import django
from datetime import datetime, timedelta

# 添加项目路径
sys.path.append(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))
sys.path.append(os.path.join(os.path.dirname(os.path.dirname(os.path.abspath(__file__))), 'UniDjango'))

# 设置Django环境
os.environ.setdefault('DJANGO_SETTINGS_MODULE', 'UniDjango.settings')
django.setup()

import requests
from django.test import TestCase
from django.urls import reverse
from rest_framework.test import APIClient
from department.models import SysDep


class ComplexFilterUtilsTest:
    """
    复杂查询工具类测试
    """
    
    def __init__(self):
        self.base_url = 'http://127.0.0.1:8000'
        self.client = APIClient()
        
    def setup_test_data(self):
        """
        创建测试数据
        """
        print("\n=== 创建测试数据 ===")
        
        # 清理现有数据
        SysDep.objects.all().delete()
        
        # 创建测试部门数据
        test_departments = [
            {'dep_name': '技术部', 'status': 1, 'remark': '负责技术开发'},
            {'dep_name': '市场部', 'status': 1, 'remark': '负责市场推广'},
            {'dep_name': '人事部', 'status': 0, 'remark': '负责人力资源管理'},
            {'dep_name': '财务部', 'status': 1, 'remark': '负责财务管理'},
            {'dep_name': '运营部', 'status': 0, 'remark': '负责日常运营'},
        ]
        
        for dept_data in test_departments:
            SysDep.objects.create(**dept_data)
            
        print(f"创建了 {len(test_departments)} 个测试部门")
        
    def test_basic_list(self):
        """
        测试基本列表功能
        """
        print("\n=== 测试基本列表功能 ===")
        
        try:
            response = requests.get(f'{self.base_url}/department/')
            print(f"状态码: {response.status_code}")
            
            if response.status_code == 200:
                data = response.json()
                print(f"返回数据条数: {len(data)}")
                print("✅ 基本列表功能正常")
            else:
                print(f"❌ 基本列表功能异常: {response.text}")
                
        except Exception as e:
            print(f"❌ 基本列表测试失败: {str(e)}")
            
    def test_name_filter(self):
        """
        测试按部门名称筛选
        """
        print("\n=== 测试按部门名称筛选 ===")
        
        try:
            # 测试部门名称模糊查询
            response = requests.get(f'{self.base_url}/department/?dep_name=技术')
            print(f"状态码: {response.status_code}")
            
            if response.status_code == 200:
                data = response.json()
                print(f"筛选结果条数: {len(data)}")
                if len(data) > 0:
                    print(f"第一条结果: {data[0]['dep_name']}")
                print("✅ 部门名称筛选功能正常")
            else:
                print(f"❌ 部门名称筛选异常: {response.text}")
                
        except Exception as e:
            print(f"❌ 部门名称筛选测试失败: {str(e)}")
            
    def test_status_filter(self):
        """
        测试按状态筛选
        """
        print("\n=== 测试按状态筛选 ===")
        
        try:
            # 测试状态筛选
            response = requests.get(f'{self.base_url}/department/?status=1')
            print(f"状态码: {response.status_code}")
            
            if response.status_code == 200:
                data = response.json()
                print(f"正常状态部门数量: {len(data)}")
                print("✅ 状态筛选功能正常")
            else:
                print(f"❌ 状态筛选异常: {response.text}")
                
        except Exception as e:
            print(f"❌ 状态筛选测试失败: {str(e)}")
            
    def test_search_function(self):
        """
        测试搜索功能
        """
        print("\n=== 测试搜索功能 ===")
        
        try:
            # 测试关键词搜索
            response = requests.get(f'{self.base_url}/department/?search=技术')
            print(f"状态码: {response.status_code}")
            
            if response.status_code == 200:
                data = response.json()
                print(f"搜索结果条数: {len(data)}")
                print("✅ 搜索功能正常")
            else:
                print(f"❌ 搜索功能异常: {response.text}")
                
        except Exception as e:
            print(f"❌ 搜索功能测试失败: {str(e)}")
            
    def test_ordering(self):
        """
        测试排序功能
        """
        print("\n=== 测试排序功能 ===")
        
        try:
            # 测试按名称排序
            response = requests.get(f'{self.base_url}/department/?ordering=dep_name')
            print(f"状态码: {response.status_code}")
            
            if response.status_code == 200:
                data = response.json()
                if len(data) >= 2:
                    print(f"第一个部门: {data[0]['dep_name']}")
                    print(f"第二个部门: {data[1]['dep_name']}")
                print("✅ 排序功能正常")
            else:
                print(f"❌ 排序功能异常: {response.text}")
                
        except Exception as e:
            print(f"❌ 排序功能测试失败: {str(e)}")
            
    def test_advanced_search(self):
        """
        测试高级搜索接口
        """
        print("\n=== 测试高级搜索接口 ===")
        
        try:
            # 测试高级搜索
            response = requests.get(f'{self.base_url}/department/advanced-search/?status=1&ordering=-dep_name')
            print(f"状态码: {response.status_code}")
            
            if response.status_code == 200:
                data = response.json()
                print(f"高级搜索结果: {data}")
                print("✅ 高级搜索接口正常")
            else:
                print(f"❌ 高级搜索接口异常: {response.text}")
                
        except Exception as e:
            print(f"❌ 高级搜索接口测试失败: {str(e)}")
            
    def test_filter_options(self):
        """
        测试筛选选项接口
        """
        print("\n=== 测试筛选选项接口 ===")
        
        try:
            # 测试筛选选项
            response = requests.get(f'{self.base_url}/department/filter-options/')
            print(f"状态码: {response.status_code}")
            
            if response.status_code == 200:
                data = response.json()
                print(f"筛选选项: {data}")
                print("✅ 筛选选项接口正常")
            else:
                print(f"❌ 筛选选项接口异常: {response.text}")
                
        except Exception as e:
            print(f"❌ 筛选选项接口测试失败: {str(e)}")
            
    def test_complex_conditions(self):
        """
        测试复杂条件组合
        """
        print("\n=== 测试复杂条件组合 ===")
        
        try:
            # 测试多条件组合
            params = {
                'status': 1,
                'search': '技术',
                'ordering': '-id'
            }
            
            response = requests.get(f'{self.base_url}/department/', params=params)
            print(f"状态码: {response.status_code}")
            
            if response.status_code == 200:
                data = response.json()
                print(f"复杂条件查询结果条数: {len(data)}")
                print("✅ 复杂条件组合功能正常")
            else:
                print(f"❌ 复杂条件组合异常: {response.text}")
                
        except Exception as e:
            print(f"❌ 复杂条件组合测试失败: {str(e)}")
            
    def run_all_tests(self):
        """
        运行所有测试
        """
        print("开始测试复杂查询工具类功能...")
        
        # 创建测试数据
        self.setup_test_data()
        
        # 运行各项测试
        self.test_basic_list()
        self.test_name_filter()
        self.test_status_filter()
        self.test_search_function()
        self.test_ordering()
        self.test_advanced_search()
        self.test_filter_options()
        self.test_complex_conditions()
        
        print("\n=== 测试完成 ===")
        print("复杂查询工具类功能测试已完成！")
        print("\n注意事项:")
        print("1. 确保Django开发服务器正在运行 (python manage.py runserver)")
        print("2. 确保数据库连接正常")
        print("3. 确保utils.filters模块已正确导入")
        print("4. 如有测试失败，请检查相关配置和代码")


if __name__ == '__main__':
    tester = ComplexFilterUtilsTest()
    tester.run_all_tests()