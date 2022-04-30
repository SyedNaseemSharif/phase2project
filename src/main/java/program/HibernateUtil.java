package program;
import org.hibernate.SessionFactory;




import org.hibernate.boot.Metadata;
import org.hibernate.boot.MetadataSources;
import org.hibernate.boot.registry.StandardServiceRegistry;
import org.hibernate.boot.registry.StandardServiceRegistryBuilder;

public class HibernateUtil {
	private static final SessionFactory sessionfactory;
	
	static 
	{
	try
	{
		StandardServiceRegistry standardRegistry = new StandardServiceRegistryBuilder()
                .configure("hibernate.cfg.xml").build();
		 Metadata metaData = new MetadataSources(standardRegistry).getMetadataBuilder().build();
         sessionfactory = metaData.getSessionFactoryBuilder().build();
	  } catch (Throwable th) {
          throw new ExceptionInInitializerError(th);
  }
}

public static SessionFactory getSessionFactory() {
  return sessionfactory;
}
}
