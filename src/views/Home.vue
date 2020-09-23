<template>
  <div class="todos">
    <h1>todos</h1>
    <input type="text" v-model="value" @keyup.enter="addTodo" />
    <ul>
      <li v-for="todo in todos" :key="todo.id" :class="{'completed':todo.completed}">
        <div class="view" v-if="todo != editing">
          <input type="checkbox" v-model="todo.completed" />
          <label @dblclick="editTodo(todo)">{{todo.title}}</label>
          <i class="iconfont icon-delete" @click="deleteTodo(todo)"></i>
        </div>
        <div class="edit" v-else>
          <input
            type="text"
            v-todo-focus
            v-model="editing.title"
            @blur="doneEdit"
            @keyup.enter="doneEdit"
          />
        </div>
      </li>
    </ul>
    <button class="clearCompleted" @click="clearCompleted" v-show="clearComputed">Clear completed</button>
  </div>
</template>

<script>
import { reactive, toRefs, computed } from 'vue';

export default {
  name: 'Todos',
  setup() {
    const state = reactive({
      value: '',
      todos: [],
      clearComputed: computed(() => {
        return state.todos.filter(item => item.completed).length > 0
          ? true
          : false;
      }),
      editing: null
    });

    // 添加todo
    const addTodo = () => {
      state.todos.push({
        id: state.todos.length,
        title: state.value,
        completed: false
      });
      state.value = '';
    };

    // 删除todo
    const deleteTodo = todo => {
      let index = state.todos.indexOf(todo);
      state.todos.splice(index, 1);
    };

    //修改todo
    const editTodo = todo => {
      state.editing = todo;
    };

    // 修改完成
    const doneEdit = () => {
      state.editing = null;
    };

    // 删除选中
    const clearCompleted = () => {
      const todos = state.todos;
      state.todos = todos.filter(item => !item.completed);
    };

    return {
      ...toRefs(state),
      addTodo,
      deleteTodo,
      editTodo,
      doneEdit,
      clearCompleted
    };
  },
  directives: {
    'todo-focus': function(el) {
      el.focus();
    }
  }
};
</script>
<style lang="scss">
@import url('http://at.alicdn.com/t/font_2088528_sfbobz4p7a.css');
* {
  padding: 0;
  margin: 0;
  box-sizing: border-box;
}
button {
  display: block;
  border: 0;
  background: #fff;
  padding: 10px 0;
  outline: none;
  font-size: 16px;
  color: #666;
}
.todos {
  width: 600px;
  border: 1px solid #f6f6f6;
  box-shadow: 0 1px 1px rgba(56, 41, 41, 0.1), 0 8px 0 -3px #f6f6f6,
    0 9px 1px -3px rgba(0, 0, 0, 0.1), 0 16px 0 -6px #f6f6f6,
    0 17px 2px -6px rgba(0, 0, 0, 0.1);
  margin: 100px auto;
  border-radius: 10px;
  padding: 30px;
  font-size: 20px;
  h1 {
    text-align: center;
    font-size: 40px;
    margin-bottom: 30px;
    text-transform: uppercase;
  }

  input[type='text'] {
    width: 100%;
    height: 45px;
    padding: 0 20px;
    font-size: 20px;
    outline: none;
    box-sizing: border-box;
    border: 1px solid #eee;
    margin-bottom: 10px;
  }

  ul {
    box-sizing: border-box;
    list-style: none;
    li {
      border: 1px solid #eee;
      &:not(:last-child) {
        border-bottom: 0;
      }
      &.completed {
        label {
          text-decoration: line-through;
          color: #bbb;
        }
      }

      .view {
        display: flex;
        align-items: center;
        height: 45px;

        padding: 0 10px;
        label {
          width: 100%;
          height: 100%;
          line-height: 45px;
          padding-left: 20px;
        }
        &:hover i {
          display: block;
        }
        i {
          cursor: pointer;
          font-size: 20px;
          display: none;
        }
      }

      .edit input {
        border: none;
        margin-bottom: 0;
        border: 1px solid #666;
        box-shadow: inset 0 -1px 5px 0 rgba(0, 0, 0, 0.1);
      }
    }
  }
}
</style>
