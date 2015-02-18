Return-Path: <APape@phoenixcontact.com>
In-Reply-To: <6979890.dWcEGHjvn6@voltaire>
References: <OF6F534CD3.B9570448-ONC1257DF0.00289AC2-C1257DF0.0029BB69@phoenixcontact.com>
 <2282256.5kOumjqyC5@voltaire>
 <OF6FAED1E7.E0D6E49C-ONC1257DF0.0042D59F-C1257DF0.00448642@phoenixcontact.com>
 <6979890.dWcEGHjvn6@voltaire>
MIME-Version: 1.0
From: Andreas Pape <APape@phoenixcontact.com>
Message-ID: <OFDE6F3C6C.B8D7D72A-ONC1257DF0.0050412D-C1257DF0.00521AC2@phoenixcontact.com>
Date: Wed, 18 Feb 2015 15:56:47 +0100
Content-Type: text/plain; charset="US-ASCII"
Subject: [B.A.T.M.A.N.] Antwort: Re: Antwort: Re: Question concerning
	batman-adv bug	#173 "Mesh	packets on bat0"
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

>At this point the mesh is working to your expectation ? Can you transport 

>payload across the mesh ? If so, this is a deviation from #173 - wouldn't 
you 
>agree ?

Before adding bat0 to the bridge br0 I can communicate via the mesh 
interface. I configured ip addresses for the bat0 interfaces on my devices 
and the ping worked without problems. But I understood from #173 that 
pinging was possible in that case, too. I'm referring to #173 because I 
can see the ogm messages received via wlan also at the bat0 interface, 
which was not the case in 2013.1.0 and earlier - if I remember my tests 
correctly...

In the meantime I found out that not only batman-adv stops receiving the 
ogm messages at ath0 but also the wpa_supplicant does not receive EAPOL 
frames any more as soon as bat0 is attached to the bridge br0 if I try to 
use WPA with the mesh interface (wpa_supplicant -i ath0). But I can see 
the EAPOL frames at the bridge interface br0 (via batctl td br0). Strange.

I'll come back to you as soon as I have tested your latest patches.

Thanks for your support,
Andreas



