from flask import Flask, render_template
import random
app = Flask(__name__)

# list of cat images
images = [
	"https://i1.wp.com/www.acidulante.com.br/wp-content/uploads/2013/10/anigif_enhanced-buzz-26388-1381844103-11.gif",
	"https://i1.wp.com/www.acidulante.com.br/wp-content/uploads/2013/10/anigif_enhanced-buzz-31540-1381844535-8.gif",
	"https://i1.wp.com/www.acidulante.com.br/wp-content/uploads/2013/10/anigif_enhanced-buzz-26390-1381844163-18.gif",
	"https://i1.wp.com/www.acidulante.com.br/wp-content/uploads/2013/10/anigif_enhanced-buzz-1376-1381846217-0.gif",
	"https://i1.wp.com/www.acidulante.com.br/wp-content/uploads/2013/10/anigif_enhanced-buzz-3391-1381844336-26.gif",
	"https://i1.wp.com/www.acidulante.com.br/wp-content/uploads/2013/10/anigif_enhanced-buzz-29111-1381845968-0.gif",
	"https://i1.wp.com/www.acidulante.com.br/wp-content/uploads/2013/10/anigif_enhanced-buzz-3409-1381844582-13.gif",
	"https://i1.wp.com/www.acidulante.com.br/wp-content/uploads/2013/10/anigif_enhanced-buzz-19667-1381844937-10.gif",
	"https://i1.wp.com/www.acidulante.com.br/wp-content/uploads/2013/10/anigif_enhanced-buzz-26358-1381845043-13.gif",
	"https://i1.wp.com/www.acidulante.com.br/wp-content/uploads/2013/10/anigif_enhanced-buzz-18774-1381844645-6.gif",
	"https://i1.wp.com/www.acidulante.com.br/wp-content/uploads/2013/10/anigif_enhanced-buzz-25158-1381844793-0.gif",
	"https://i1.wp.com/www.acidulante.com.br/wp-content/uploads/2013/10/anigif_enhanced-buzz-11980-1381846269-1.gif"
]

@app.route('/')
def index():
	url = random.choice(images)
	return render_template('index.html', url=url)

if __name__ == "__main__":
	app.run(host="0.0.0.0")
