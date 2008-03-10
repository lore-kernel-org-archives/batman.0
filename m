Message-ID: <51517.70.253.200.118.1205126246.squirrel@webmail.reglue.org>
In-Reply-To: <1205102957.4658.42.camel@krupskaya.is-a-geek.net.is-a-geek.net>
References: <1205102957.4658.42.camel@krupskaya.is-a-geek.net.is-a-geek.net>
Date: Sun, 9 Mar 2008 22:17:26 -0700 (PDT)
Subject: Re: [B.A.T.M.A.N.] b.a.t.m.a.n. + wrt54gl + OpenWrt Kamikaze + X-wrt
From: dondavis@reglue.org
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@open-mesh.net>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.open-mesh.net>
List-Unsubscribe: <https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=unsubscribe>
List-Archive: <http://list.open-mesh.net/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@open-mesh.net>
List-Help: <mailto:b.a.t.m.a.n-request@open-mesh.net?subject=help>
List-Subscribe: <https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=subscribe>
To: dondavis@reglue.org, The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@open-mesh.net>

I have 8 wrt54gl's running openwrt + batman.  I set all to auto channel +
ad-hoc.


I'm trying this startup script.
ifconfig eth0.0 103.0.0.* netmask 255.0.0.0 broadcast 103.255.255.255 &
ifconfig wl0 103.0.0.* netmask 255.0.0.0 broadcast 103.255.255.255 &
batmand eth0.0 eth0.1 wl0 &
iptables -t filter -I INPUT 2 -p udp --dport 1966 --sport 1966 -j ACCEPT &
iptables -t filter -I OUTPUT 2 -p udp --dport 1966 --sport 1966 -j ACCEPT
&


I did a kismet scan and only 4 are showing up.  All 8 have wlan lights
blinking in sync.

Should I manually set the channel?

Do the essids matter?

Should the lan ip be the same as the ip I give the batman device?

do I need to use wan ips?




One shows up- Channel 10 ap-
 Name    : mobileWRT                                            &#9474;
&#9474;|&#9474;                                                           
    &#9474;
&#9474;|&#9474; SSID    : mobileWRT                                       
    &#9474;
&#9474;|&#9474; Server  : localhost:2501                                  
    &#9474;
&#9474; &#9474; BSSID   : 00:1C:10:BC:AC:68                               
    &#9474;
&#9474; &#9474; Carrier : IEEE 802.11g                                    
    &#9474;
&#9474; &#9474; Manuf   : Unknown                                         
    &#9474;
&#9474; &#9474; Max Rate: 54.0                                            
    &#9474;
&#9474; &#9474; BSS Time: 2b688188                                        
    &#9474;
&#9474; &#9474; Max Seen: 1000 kbps                                       
    &#9474;
&#9474; &#9474; First   : Sun Mar  9 19:34:06 2008                        
    &#9474;
&#9474; &#9474; Latest  : Sun Mar  9 19:40:38 2008                        
    &#9474;
&#9474; &#9474; Clients : 0                                               
    &#9474;
&#9474; &#9474; Type    : Access Point (infrastructure)                   
    &#9474;
&#9492;&#9472;&#9474; Info    :                                           
          &#9474;
&#9484;&#9472;&#9474; Channel : 10                                        
          &#9474;
&#9474; &#9474;

3 ad-hocs
&#9474;-&#9474; Name    : Adhoc networks                                  
  &#9474; &#9474;
&#9474;|&#9474; Networks: 3                                               
  &#9474; &#9474;
&#9474;|&#9474; Min Loc : N/A                                             
  &#9474; &#9474;
&#9474;|&#9474; Max Loc : N/A                                             
  &#9474; &#9474;
&#9474; &#9474; Range   : N/A                                             
  &#9474; &#9474;
&#9474; &#9474; Carrier : IEEE 802.11g                                    
  &#9474; &#9474;
&#9474; &#9474;                                                           
  &#9474; &#9474;
&#9474; &#9474; Network 1                                                 
  &#9474; &#9474;
&#9474; &#9474; SSID    : OpenWrt                                         
  &#9474; &#9474;
&#9474; &#9474; Server  : localhost:2501                                  
  &#9474; &#9474;
&#9474; &#9474; BSSID   : 42:19:24:94:DF:5E                               
  &#9474; &#9474;
&#9474; &#9474; Carrier : IEEE 802.11g                                    
  &#9474; &#9474;
&#9474; &#9474; Manuf   : Unknown                                         
  &#9474; &#9474;
&#9474; &#9474; Max Rate: 11.0
 Clients : 15                                                 &#9474; &#9474;
&#9474; &#9474; Type    : Ad-hoc                                          
  &#9474; &#9474;
&#9474; &#9474; Info    :                                                 
  &#9474; &#9474;
&#9474; &#9474; Channel : 1                                               
  &#9474; &#9474;
&#9474; &#9474; Privacy : No                                              
  &#9474; &#9474;
&#9474; &#9474; Encrypt : None


 Network 2                                                    &#9474; &#9474;
&#9474;|&#9474; SSID    : project5                                        
  &#9474; &#9474;
&#9474;|&#9474; Server  : localhost:2501                                  
  &#9474; &#9474;
&#9474; &#9474; BSSID   : 4E:FC:E3:89:31:9E                               
  &#9474; &#9474;
&#9474; &#9474; Carrier : IEEE 802.11g                                    
  &#9474; &#9474;
&#9474; &#9474; Manuf   : Unknown                                         
  &#9474; &#9474;
&#9474; &#9474; Max Rate: 54.0                                            
  &#9474; &#9474;
&#9474; &#9474; BSS Time: e480e183                                        
  &#9474; &#9474;
&#9474; &#9474; Max Seen: 1000 kbps                                       
  &#9474; &#9474;
&#9474; &#9474; First   : Sun Mar  9 19:34:06 2008                        
  &#9474; &#9474;
&#9474; &#9474; Latest  : Sun Mar  9 20:35:55 2008                        
  &#9474; &#9474;
&#9474; &#9474; Clients : 5                                               
  &#9474; &#9474;
&#9474; &#9474; Type    : Ad-hoc                                          
  &#9474; &#9474;
&#9474; &#9474; Info    :                                                 
  &#9474; &#9474;
&#9474; &#9474; Channel : 11                                              
  &#9474; &#9474;
&#9474; &#9474; Privacy : No                                              
  &#9474; &#9474;
&#9474;+&#9474; Encrypt : None


 Network 3                                                    &#9474; &#9474;
&#9474; &#9474; SSID    : mobileWRT                                       
  &#9474; &#9474;
&#9474; &#9474; Server  : localhost:2501                                  
  &#9474; &#9474;
&#9474; &#9474; BSSID   : D6:4E:A1:DA:E5:55                               
  &#9474; &#9474;
&#9474; &#9474; Carrier : IEEE 802.11g                                    
  &#9474; &#9474;
&#9474; &#9474; Manuf   : Unknown                                         
  &#9474; &#9474;
&#9474;+&#9474; Max Rate: 11.0
 Type    : Ad-hoc                                             &#9474; &#9474;
&#9474; &#9474; Info    :                                                 
  &#9474; &#9474;
&#9474; &#9474; Channel : 11                                              
  &#9474; &#9474;
&#9474; &#9474; Privacy : No                                              
  &#9474; &#9474;
&#9474; &#9474; Encrypt : None





