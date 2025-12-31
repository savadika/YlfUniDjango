#!/usr/bin/env python
"""
分页功能测试脚本
测试部门模块的分页功能
"""

import os
import sys
import django
import requests
import json
from datetime import datetime

# 添加项目路径
sys.path.append(os.path.join(os.path.dirname(__file__), '..', 'UniDjango'))

# 设置Django环境
os.environ.setdefault('DJANGO_SETTINGS_MODULE', 'UniDjango.settings')
django.setup()

from department.models import SysDep

# API基础URL
BASE_URL = 'http://127.0.0.1:8000'
DEPARTMENT_URL = f'{BASE_URL}/department'

def create_test_data():
    """
    创建测试数据
    """
    print("\n=== 创建测试数据 ===")
    
    # 清除现有数据
    SysDep.objects.all().delete()
    
    # 创建25条测试数据
    departments = []
    for i in range(1, 26):
        dept = SysDep.objects.create(
            dep_name=f'部门{i:02d}',
            status=1 if i % 2 == 0 else 0,
            remark=f'这是第{i}个测试部门'
        )
        departments.append(dept)
    
    print(f"创建了 {len(departments)} 条测试数据")
    return departments

def test_default_pagination():
    """
    测试默认分页
    """
    print("\n=== 测试默认分页 ===")
    
    try:
        # 测试第一页
        response = requests.get(f'{DEPARTMENT_URL}/')
        if response.status_code == 200:
            data = response.json()
            print(f"第一页数据:")
            print(f"  总记录数: {data.get('count')}")
            print(f"  总页数: {data.get('total_pages')}")
            print(f"  当前页: {data.get('current_page')}")
            print(f"  每页大小: {data.get('page_size')}")
            print(f"  当前页记录数: {len(data.get('results', []))}")
            print(f"  下一页链接: {'有' if data.get('next') else '无'}")
            print(f"  上一页链接: {'有' if data.get('previous') else '无'}")
        else:
            print(f"请求失败: {response.status_code}")
            
        # 测试第二页
        response = requests.get(f'{DEPARTMENT_URL}/?page=2')
        if response.status_code == 200:
            data = response.json()
            print(f"\n第二页数据:")
            print(f"  当前页: {data.get('current_page')}")
            print(f"  当前页记录数: {len(data.get('results', []))}")
            print(f"  下一页链接: {'有' if data.get('next') else '无'}")
            print(f"  上一页链接: {'有' if data.get('previous') else '无'}")
        
    except requests.exceptions.ConnectionError:
        print("连接失败，请确保Django服务器正在运行")
    except Exception as e:
        print(f"测试失败: {e}")

def test_custom_page_size():
    """
    测试自定义每页大小
    """
    print("\n=== 测试自定义每页大小 ===")
    
    try:
        # 测试每页5条记录
        response = requests.get(f'{DEPARTMENT_URL}/?page_size=5')
        if response.status_code == 200:
            data = response.json()
            print(f"每页5条记录:")
            print(f"  总页数: {data.get('total_pages')}")
            print(f"  每页大小: {data.get('page_size')}")
            print(f"  当前页记录数: {len(data.get('results', []))}")
        
        # 测试每页15条记录
        response = requests.get(f'{DEPARTMENT_URL}/?page_size=15')
        if response.status_code == 200:
            data = response.json()
            print(f"\n每页15条记录:")
            print(f"  总页数: {data.get('total_pages')}")
            print(f"  每页大小: {data.get('page_size')}")
            print(f"  当前页记录数: {len(data.get('results', []))}")
            
    except requests.exceptions.ConnectionError:
        print("连接失败，请确保Django服务器正在运行")
    except Exception as e:
        print(f"测试失败: {e}")



def main():
    """
    主函数
    """
    print("分页功能测试开始...")
    print(f"测试时间: {datetime.now()}")
    
    # 创建测试数据
    create_test_data()
    
    # 运行各项测试
    test_default_pagination()
    test_custom_page_size()
    
    print("\n=== 分页功能测试完成 ===")
    print("\n可用的分页API接口:")
    print("1. GET /department/ - 默认分页（每页10条）")
    print("2. GET /department/?page=2 - 指定页码")
    print("3. GET /department/?page_size=5 - 自定义每页大小")
    print("4. GET /department/?page=2&page_size=5 - 组合参数")

if __name__ == '__main__':
    main()