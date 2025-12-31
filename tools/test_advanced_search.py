#!/usr/bin/env python
# -*- coding: utf-8 -*-
"""
高级搜索功能测试脚本
测试部门管理的高级搜索功能
"""

import requests
import json
from urllib.parse import urlencode

# 配置
BASE_URL = 'http://127.0.0.1:8000'
DEPARTMENT_URL = f'{BASE_URL}/department/'

def test_search(params, description):
    """
    测试搜索功能
    
    Args:
        params: 搜索参数字典
        description: 测试描述
    """
    print(f"\n{'='*60}")
    print(f"测试: {description}")
    print(f"参数: {params}")
    
    try:
        # 构建URL
        url = f"{DEPARTMENT_URL}?{urlencode(params)}"
        print(f"请求URL: {url}")
        
        # 发送请求
        response = requests.get(url)
        
        if response.status_code == 200:
            data = response.json()
            print(f"状态码: {response.status_code}")
            print(f"总记录数: {data.get('count', 0)}")
            print(f"总页数: {data.get('total_pages', 0)}")
            print(f"当前页: {data.get('current_page', 0)}")
            print(f"当前页记录数: {len(data.get('results', []))}")
            
            # 显示前3条记录的详细信息
            results = data.get('results', [])
            if results:
                print("\n前3条记录:")
                for i, item in enumerate(results[:3]):
                    print(f"  {i+1}. ID: {item.get('id')}, 部门名称: {item.get('dep_name')}, "
                          f"状态: {item.get('status')}, 备注: {item.get('remark')}, "
                          f"创建时间: {item.get('create_time')}, 更新时间: {item.get('update_time')}")
            else:
                print("没有找到匹配的记录")
        else:
            print(f"请求失败，状态码: {response.status_code}")
            print(f"错误信息: {response.text}")
            
    except Exception as e:
        print(f"请求异常: {str(e)}")

def create_test_data():
    """
    创建测试数据
    """
    print("创建测试数据...")
    
    test_departments = [
        {
            "dep_name": "技术部",
            "status": 1,
            "remark": "负责技术开发和维护",
            "create_time": "2025-01-10",
            "update_time": "2025-01-15"
        },
        {
            "dep_name": "市场部",
            "status": 1,
            "remark": "负责市场推广和销售",
            "create_time": "2025-01-12",
            "update_time": "2025-01-16"
        },
        {
            "dep_name": "人事部",
            "status": 0,
            "remark": "负责人力资源管理",
            "create_time": "2025-01-08",
            "update_time": "2025-01-14"
        },
        {
            "dep_name": "财务部",
            "status": 1,
            "remark": "负责财务管理和会计",
            "create_time": "2025-01-05",
            "update_time": "2025-01-13"
        }
    ]
    
    for dept in test_departments:
        try:
            response = requests.post(DEPARTMENT_URL, json=dept)
            if response.status_code == 201:
                print(f"✓ 创建部门: {dept['dep_name']}")
            else:
                print(f"✗ 创建部门失败: {dept['dep_name']}, 状态码: {response.status_code}")
        except Exception as e:
            print(f"✗ 创建部门异常: {dept['dep_name']}, 错误: {str(e)}")

def test_basic_list():
    """
    测试基本列表功能
    """
    test_search({}, "基本列表查询（无过滤条件）")

def test_pagination():
    """
    测试分页功能
    """
    test_search({'page': 1, 'page_size': 2}, "分页测试（第1页，每页2条）")
    test_search({'page': 2, 'page_size': 2}, "分页测试（第2页，每页2条）")

def test_field_search():
    """
    测试字段搜索功能
    """
    # 测试部门名称搜索
    test_search({'dep_name': '技术'}, "部门名称模糊搜索（技术）")
    test_search({'dep_name': '部'}, "部门名称模糊搜索（部）")
    
    # 测试备注搜索
    test_search({'remark': '负责'}, "备注模糊搜索（负责）")
    test_search({'remark': '技术'}, "备注模糊搜索（技术）")
    
    # 测试状态搜索
    test_search({'status': 1}, "状态搜索（正常）")
    test_search({'status': 0}, "状态搜索（禁用）")

def test_time_range_search():
    """
    测试时间范围搜索功能
    """
    # 测试创建时间范围
    test_search({
        'create_time_start': '2025-01-08',
        'create_time_end': '2025-01-12'
    }, "创建时间范围搜索（2025-01-08 到 2025-01-12）")
    
    # 测试更新时间范围
    test_search({
        'update_time_start': '2025-01-14',
        'update_time_end': '2025-01-16'
    }, "更新时间范围搜索（2025-01-14 到 2025-01-16）")

def test_global_search():
    """
    测试全局搜索功能
    """
    test_search({'search': '技术'}, "全局搜索（技术）")
    test_search({'search': '负责'}, "全局搜索（负责）")
    test_search({'search': '市场'}, "全局搜索（市场）")

def test_combined_search():
    """
    测试组合搜索功能
    """
    # 组合搜索：状态 + 部门名称
    test_search({
        'status': 1,
        'dep_name': '部'
    }, "组合搜索（状态=正常 + 部门名称包含'部'）")
    
    # 组合搜索：时间范围 + 状态
    test_search({
        'create_time_start': '2025-01-08',
        'create_time_end': '2025-01-12',
        'status': 1
    }, "组合搜索（创建时间范围 + 状态=正常）")
    
    # 复杂组合搜索
    test_search({
        'page': 1,
        'page_size': 5,
        'dep_name': '技术部',
        'status': 1,
        'remark': '1212',
        'create_time_start': '2025-09-09',
        'create_time_end': '2025-09-12',
        'update_time_start': '2025-09-02',
        'update_time_end': '2025-09-05'
    }, "复杂组合搜索（用户提供的示例URL参数）")

def main():
    """
    主函数
    """
    print("高级搜索功能测试开始")
    print(f"测试目标: {DEPARTMENT_URL}")
    
    # 创建测试数据
    create_test_data()
    
    # 基本功能测试
    test_basic_list()
    test_pagination()
    
    # 字段搜索测试
    test_field_search()
    
    # 时间范围搜索测试
    test_time_range_search()
    
    # 全局搜索测试
    test_global_search()
    
    # 组合搜索测试
    test_combined_search()
    
    print(f"\n{'='*60}")
    print("高级搜索功能测试完成")
    print("\n测试说明:")
    print("1. 确保Django服务器正在运行 (python manage.py runserver)")
    print("2. 确保数据库中有测试数据")
    print("3. 所有搜索参数都支持组合使用")
    print("4. 支持的搜索参数:")
    print("   - dep_name: 部门名称模糊搜索")
    print("   - remark: 备注模糊搜索")
    print("   - status: 状态精确匹配")
    print("   - create_time_start/end: 创建时间范围")
    print("   - update_time_start/end: 更新时间范围")
    print("   - search: 全局搜索（搜索部门名称和备注）")
    print("   - page: 页码")
    print("   - page_size: 每页记录数")

if __name__ == '__main__':
    main()