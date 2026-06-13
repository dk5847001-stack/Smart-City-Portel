import { Mail, MapPin, Phone } from "lucide-react";

const Contact = () => {
  return (
    <section className="py-5 public-page">
      <div className="container">
        <div className="section-heading">
          <span>Contact</span>
          <h1>Reach the smart city support desk</h1>
          <p>For urgent civic issues, use the complaint form. For portal help, contact the support team.</p>
        </div>
        <div className="row g-4">
          {[
            [MapPin, "Office", "Smart City Civic Center, Indore"],
            [Phone, "Helpline", "+91 62005 76221"],
            [Mail, "Email", "support@smartcityportal.local"]
          ].map(([Icon, title, text]) => (
            <div className="col-md-4" key={title}>
              <div className="public-card h-100">
                <Icon size={32} />
                <h2>{title}</h2>
                <p>{text}</p>
              </div>
            </div>
          ))}
        </div>
      </div>
    </section>
  );
};

export default Contact;
