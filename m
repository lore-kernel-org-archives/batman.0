Return-Path: <APape@phoenixcontact.com>
In-Reply-To: <23381002.yeogTpj88W@voltaire>
References: <OF6F534CD3.B9570448-ONC1257DF0.00289AC2-C1257DF0.0029BB69@phoenixcontact.com>
 <OFDE6F3C6C.B8D7D72A-ONC1257DF0.0050412D-C1257DF0.00521AC2@phoenixcontact.com>
 <OFC2424D81.A822433D-ONC1257DF0.005393B1-C1257DF0.005470B6@phoenixcontact.com>
 <23381002.yeogTpj88W@voltaire>
MIME-Version: 1.0
From: Andreas Pape <APape@phoenixcontact.com>
Message-ID: <OF9D4BC429.65445525-ONC1257DF0.0057EC95-C1257DF0.0058D385@phoenixcontact.com>
Date: Wed, 18 Feb 2015 17:10:12 +0100
Content-Type: text/plain; charset="US-ASCII"
Subject: [B.A.T.M.A.N.] Antwort: Re: Antwort: Antwort: Re: Antwort: Re:
	Question	concerning	batman-adv bug	#173 "Mesh	packets on bat0"
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

Hi Marek,

I reverted the changes step by step starting with patch 
0002-remove-netdev_calls.patch, as patch 1 did not help and patch 3 
containes in compat.h and soft-interface.c, I tried out myself earlier 
today.

The essential call is in patch 2 as assumed. As soon as I add the 
netdev_master_upper_dev_link call again to the compilable code, the 
problem starts to occur (mesh doesn't work as soon as bat0 is added to the 
bridge, ogm packets can be seen at bat0). It seems that this call behaves 
in older kernels different compared to newer ones.

I haven't tried to add all the other excluded parts again except for the 
netdev_master_upper_dev_link call. If you are interested I can test this 
tomorrow, too.

Regards,
Andreas

