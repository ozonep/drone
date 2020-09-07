<template>
  <div class="container">
    <div class="logout">
      <h1>You are now signed out</h1>
    </div>
  </div>
</template>

<style scoped lang="scss">
@import "../assets/styles/mixins";

div.container {
  align-items: center;
  background: $body-color;
  box-sizing: border-box;
  display: flex;
  justify-content: center;
  padding: 30px;
  height: 100%;
  width: 100%;
}

.logout {
  width: 300px;

  background: $surface-color;
  border: 1px solid $border-color;
  border-radius: 3px;
  box-shadow: 0px 0px 8px 1px darken($body-color, 20%);
  padding: 30px;
}
</style>
