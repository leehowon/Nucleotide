import java.io.IOException;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import org.apache.http.HttpResponse;
import org.apache.http.NameValuePair;
import org.apache.http.client.ClientProtocolException;
import org.apache.http.client.HttpClient;
import org.apache.http.client.HttpResponseException;
import org.apache.http.client.entity.UrlEncodedFormEntity;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.impl.client.BasicResponseHandler;
import org.apache.http.impl.client.HttpClientBuilder;
import org.apache.http.message.BasicNameValuePair;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;

public class DriverClass
{
    public static void main( String[] ar )
    {
        //DC1XJNMD015 - blastn, DB53815G014 - blastx
        String url = "http://blast.ncbi.nlm.nih.gov/Blast.cgi";

        HttpClient httpClient = HttpClientBuilder.create().build();
        HttpPost post = new HttpPost( url );
        List<NameValuePair> params = new ArrayList<NameValuePair>();
        
        params.add( new BasicNameValuePair("CMD", "Get") );
        params.add( new BasicNameValuePair("RID", "DC1XJNMD015") );
        params.add( new BasicNameValuePair("SHOW_OVERVIEW", "no") );
        params.add( new BasicNameValuePair("DESCRIPTIONS", "100") );

        try
        {
            post.setHeader( "Cache-Control", "no-cache, no-store, must-revalidate" );
            post.setHeader( "Pragma", "no-cache" );
            post.setHeader( "Expires", "0" );
            post.setEntity( new UrlEncodedFormEntity(params) );
            
            String str = httpClient.execute(post, new BasicResponseHandler() 
            {
                @Override
                public String handleResponse(HttpResponse response)
                        throws HttpResponseException, IOException
                {
                    String htmlStr = super.handleResponse( response );
                    Document doc = Jsoup.parse( htmlStr );
                    Elements rows = doc.select( "#dscTable tbody tr" );
                    StringBuffer sb = new StringBuffer();
                    int rowNum = 1;
                    
                    for( Element row : rows )
                    {
                        //Iterator< Element > iterElem = row.getElementsByTag( "td" ).;
                        Elements elements = row.getElementsByTag( "td" ); 
                        
                        //detail page : http://www.ncbi.nlm.nih.gov/nucleotide/723677642?report=genbank&RID=DC1XJNMD015
                        sb.append( "getSeqGi : " ).append( row.getElementById( "chk_" + rowNum ).val() );
                        sb.append( "\nDescription : " ).append( elements.get(1).text() );
                        sb.append( "\nMax score : " ).append( elements.get(2).text() );
                        sb.append( "\nTotal score : " ).append( elements.get(3).text() );
                        sb.append( "\nQuery cover : " ).append( elements.get(4).text() );
                        sb.append( "\nE value : " ).append( elements.get(5).text() );
                        sb.append( "\nIdent : " ).append( elements.get(6).text() );
                        sb.append( "\nAccession : " ).append( elements.get(7).text() );
                        sb.append( "\n\n" );
                        
                        rowNum++;
                    }
                    
                    System.out.println( sb.toString() );
                    //Elements rows = doc.select( "table.table_board2 tbody tr" );
                    
                    
                    return htmlStr != "" ? "" : "";
                }
            });
            
            System.out.println( str );
        } catch (ClientProtocolException e) {
          e.printStackTrace();
        } catch (IOException e) {
          e.printStackTrace();
        }
    }
}
