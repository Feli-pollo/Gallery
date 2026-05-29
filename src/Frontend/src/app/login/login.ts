import { Component, inject } from '@angular/core';
import { LoginService } from '../shared/login.service';
import { FormsModule } from '@angular/forms'

@Component({
  selector: 'app-login',
  imports: [FormsModule],
  templateUrl: './login.html',
  styleUrl: './login.css',
})
export class Login {
  service = inject(LoginService);
  login = {
    user: '',
    password: ''
  };

  onSubmit(form: any) {
    if (form.invalid) {
      return;
    }
    console.log(form);
    //LOGICA PARA EL LOGIN
    this.service.login(this.login).subscribe({
      next: (response) => {
        let status = response.status;
        if (status === 200) {
          let data = response.body;
          localStorage.setItem('token', data.token);
          localStorage.setItem('expirationDate', data.expirationDate);
        }
        console.log(response);
      },
      error: (err) => {
        console.error(err);
        alert(err.error);
      }

    })
  }
}
