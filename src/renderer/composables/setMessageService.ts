import { ref } from "vue";

export default function useSetMessageService() {
  const successMessage = ref("");
  const errorMessage = ref("");

  const setMessage = (type: "success" | "error", message: string) => {
    if (type === "success") {
      successMessage.value = message;
      errorMessage.value = null;
    } 
    else {
      errorMessage.value = message;
      successMessage.value = null;
    }
  };

  return {
    successMessage,
    errorMessage,
    setMessage,
  };
}
