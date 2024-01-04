import { createRouter, createWebHistory } from "vue-router"

const routes = [
    {
        path: '/',
        name: 'login',
        hidden: true,
        component: () => import('@/views/login/MainLogin')
    },
    {
        path: '/administrator',
        name: 'administrator',
        meta:{name:'舍管',}, 
        redirect: '/administrator/self',
        component: () => import('@/components/Administrator/AdministratorMain'),
        children: [{
            path: '/administrator/self',
            name: 'administratorself',
            icon:'fa fa-user',
            redirect: '/administrator/self/show',
            meta:{name:'个人',}, 
            children: [
                {
                    path: '/administrator/self/show',
                    name: 'administratorselfshow',
                    meta:{name:'个人信息',}, 
                    icon:'fa fa-vcard',
                    component: () => import('@/components/Administrator/self/ShowSelf'),
                },
                {
                    path: '/administrator/self/alter',
                    name: 'administratorselfalter',
                    meta:{name:'修改个人信息',}, 
                    icon:'fa fa-pencil',
                    component: () => import('@/components/Administrator/self/AlterSelf'),
                }
            ],
        },
        {
            path: '/administrator/stu',
            name: 'administratorstu',
            meta:{name:'学生管理',}, 
            icon:'fa fa-users',
            redirect: '/administrator/stu/show',
            children: [{
                path: '/administrator/stu/show',
                name: 'administratorstushow',
                meta:{name:'查看学生',}, 
                icon:'fa fa-users',
                component: () => import('@/components/Administrator/student/ShowStu'),
            },
            {
                path: '/administrator/stu/alter',
                name: 'administratorstualter',
                meta:{name:'修改学生',},
                icon:'fa fa-pencil', 
                hidden: true,
                component: () => import('@/components/Administrator/student/AlterStu'),
            },
            ],
        },
        {
            path: '/administrator/dorm',
            name: 'administratordorm',
            meta:{name:'宿舍管理',}, 
            icon:'fa fa-university',
            redirect: '/administrator/dorm/show',
            children: [{
                path: '/administrator/dorm/show',
                name: 'administratordormshow',
                meta:{name:'宿舍信息',}, 
                icon:'fa fa-pencil', 
                component: () => import('@/components/Administrator/dorm/ShowDorm'),
            },
            {
                path: '/administrator/dorm/wealth',
                meta:{name:'宿舍财产',}, 
                name: 'administratordormwealth',
                icon:'fa fa-pencil', 
                component: () => import('@/components/Administrator/dorm/WealthDorm'),
            },
            {
                path: '/administrator/dorm/reapir',
                meta:{name:'查询报修',}, 
                icon:'fa fa-pencil', 
                name: 'administratorshowrepair',
                component: () => import('@/components/Administrator/dorm/ShowRepair'),
            },
            {
                path: '/administrator/dorm/alter',
                meta:{name:'修改报修',}, 
                icon:'fa fa-pencil', 
                name: 'administratordormalter',
                component: () => import('@/components/Administrator/dorm/AlterRepair'),
            },
        ],
        },
        {
            path: '/administrator/floor',
            name: 'administratorfloor',
            meta:{name:'宿舍楼管理',}, 
            icon:'fa fa-pencil', 
            redirect: '/administrator/floor/show',
            children: [{
                path: '/administrator/floor/show',
                name: 'administratorfloorshow',
                meta:{name:'宿舍楼信息',}, 
                icon:'fa fa-pencil', 
                component: () => import('@/components/Administrator/floor/ShowFloor'),
            },
            {
                path: '/administrator/floor/alter',
                name: 'administratorflooralter',
                meta:{name:'修改楼信息',}, 
                icon:'fa fa-pencil', 
                component: () => import('@/components/Administrator/floor/AlterFloor'),
            }
        ],
        },
        {
            path: '/administrator/account',
            name: 'administratoraccount',
            meta:{name:'账号',}, 
            icon:'fa fa-vcard', 
            redirect: '/administrator/account/alter',
            children: [{
                path: '/administrator/account/alter',
                name: 'administratoraccountalter',
                meta:{name:'修改账号',}, 
                icon:'fa fa-pencil', 
                component: () => import('@/components/Administrator/account/AlterAccount'),
            },
            {
                path: '/administrator/account/logout',
                name: 'administratoraccountlogout',
                meta:{name:'退出',}, 
                icon:'fa fa-vcard',
                component: () => import('@/components/Administrator/account/LogoutAccount'),
            }],
        },
        ]
    },
    {
        path: "/404",
        name: "404Error",
        hidden: true,
        component: () => import("@/views/error/404Error")
    },
]
export const router = createRouter({
    history: createWebHistory(),
    routes: routes
})

export default router
