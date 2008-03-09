Subject: Re: [B.A.T.M.A.N.] b.a.t.m.a.n. + wrt54gl + OpenWrt Kamikaze + X-wrt
From: Donald Davis <dondavis@reglue.org>
Content-Type: text/plain
Date: Sun, 09 Mar 2008 17:49:17 -0500
Message-Id: <1205102957.4658.42.camel@krupskaya.is-a-geek.net.is-a-geek.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Reply-To: dondavis@reglue.org,
	The list for a Better Approach To Mobile Ad-hoc Networking
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
To: b.a.t.m.a.n@open-mesh.net

I guess I should start with:
        1. How should I set up the preferred gateway?
        2. what do I need to do besides batmand interface?  
        3.  Thoughts on how to setup a second nic on a computer in order
        to
        allow it to work as a visualization server?  
        
        
        
        
        On Sun, 2008-03-09 at 22:07 +0100, elektra wrote:
        > 1. You have to use ad-hoc - multipoint to multipoint
        networking is what 
        > mesh networking is all about.
        I kind of figured.  But the fact it wasn't working led me to
        question a
        lot... 
        
        > 2. Did you check your firewall settings - in doubt try
        disabling it for 
        > a test (iptables -F)  
        
        Okay.  I'll try that.  I was looking at some routing some of the
        udp
        packages batman needs.  well iptables -F killed the router (that
        would
        make sense, flushing the iptables on a router)...
        
        I'll try 
        
        iptables -t filter -I INPUT 2 -p udp --dport 1966 --sport 1966
        -j
        ACCEPT;
        
        iptables -t filter -I OUTPUT 2 -p udp --dport 1966 --sport 1966
        -j
        ACCEPT;
        
        iptables -t filter -I ipfilter 5 -s 103.0.0.0/8 -d 103.0.0.0/8
        -j
        ACCEPT;
        
        > 3. The hints that you are giving are very sparse - which
        version are you 
        > using, your ip-settings etc.
        
        Sorry.  I didn't want to type a a lot of info  without knowing
        what
        would be useful.  
        
        It's Batman 0.2 compatibility  version 3. 
        
        I'm very unsure about a few things.  when I type ifconfig on the
        wrt54gl
        I have following devices 
        br-lan
        eth0
        eth0.0
        eth0.1
        lo
        wl0 
        
        the web interface on x-wrt offers me br-lan and eth0.1 by
        default and
        eth0.0 once I bring it up on the cli.   
        so I use ssh and start batmand br-lan eth0.0 eth0.1
        
         
        at one point I had vlan0 but it disappeared without my
        (consciously)
        disabling it.   
        
        I chose eth0.0 as the primary interface and routing class 1.  
        
        ifconfig eth0.0 103.0.0.(number of router) netmask 255.0.0.0
        broadcast
        103.255.255.255
        
        I'll try ifconfig br-lan 103.0.0.* and use it as the primary
        interface.
        
        

