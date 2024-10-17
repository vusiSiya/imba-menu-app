
import {
	createUserWithEmailAndPassword,
	signInWithEmailAndPassword,
	signInWithPopup,
	signInAnonymously
} from "firebase/auth"
import {auth, provider, checkAuthState } from "../../auth"
import googleLogo from "../../Images/google-logo.png"


css button fw:bold p:1em 1.5em bd:none rd:.5rem c:inherit 
	bgc:#354645 @hover:orange

css form d:grid bgc:black g:.8em min-width:15em m:.5em auto p:1em c:white 
	bd:none rd:.5rem fs:1.5rem @!700:medium 

css form > input bd:4px solid transparent @hover:4px solid blue3 rd:.25rem
	w:auto p:.5em ta:start 
	
			
tag login
	prop errorMsg = null
	
	def handleSubmit e
		const {id} = e.submitter || e.target
		try
			if e.submitter
				const formData = new FormData(e.target)
				const email = formData.get("email")
				const password = formData.get("password")
				if id === "sign-in"
					await signInWithEmailAndPassword(auth , email.toString!, password.toString!)
				else if id === "sign-up"
					await createUserWithEmailAndPassword(auth, email.toString!, password.toString!)
			else 
				if id === "google-auth" then await signInWithPopup(auth, provider)
				else await signInAnonymously(auth)
		catch error
			errorMsg = error.message
		e.submitter && e.target.reset!
		return
		
	def render
		const signedIn = checkAuthState!
		<self [m:auto c:white]>
			<form @submit.prevent()=handleSubmit>
				<h4 [ta:center]> "Sign in or Sign up"
				<p [m:0 c:orange fs:small fw:bold]> signedIn ? "Successully Signed In" : errorMsg
				errorMsg = null
				
				<input type="email" name="email" placeholder="email" required autocomplete="off" />
				<input type="password" name="password" placeholder="password" required autocomplete="off" />
				<button type="submit" id="sign-in"> "Sign In"
				<button type="submit" id="sign-up"> "Sign Up"
				<section [d:grid g:.4em]>
					<p [fs:small m:0 ta:center]> "or"
					<button type="button" id="anonymous-auth" @mousedown=handleSubmit> "Sign In Anonymously"
					<button [d:flex ai:center jc:center] type="button" id="google-auth" @mousedown=handleSubmit>
						<img [w:2rem] src=googleLogo /> "Sign In with Google"

