Return-Path: <APape@phoenixcontact.com>
In-Reply-To: <OFDE6F3C6C.B8D7D72A-ONC1257DF0.0050412D-C1257DF0.00521AC2@phoenixcontact.com>
References: <OF6F534CD3.B9570448-ONC1257DF0.00289AC2-C1257DF0.0029BB69@phoenixcontact.com>
 <2282256.5kOumjqyC5@voltaire>
 <OF6FAED1E7.E0D6E49C-ONC1257DF0.0042D59F-C1257DF0.00448642@phoenixcontact.com>
 <6979890.dWcEGHjvn6@voltaire>
 <OFDE6F3C6C.B8D7D72A-ONC1257DF0.0050412D-C1257DF0.00521AC2@phoenixcontact.com>
MIME-Version: 1.0
From: Andreas Pape <APape@phoenixcontact.com>
Message-ID: <OFC2424D81.A822433D-ONC1257DF0.005393B1-C1257DF0.005470B6@phoenixcontact.com>
Date: Wed, 18 Feb 2015 16:22:18 +0100
Content-Type: text/plain; charset="US-ASCII"
Subject: [B.A.T.M.A.N.] Antwort: Antwort: Re: Antwort: Re: Question
	concerning	batman-adv bug	#173 "Mesh	packets on bat0"
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

good news: the sum of the three patches you sent solved the problem as far 
as I have tested yet. Now bat0 works in combination with the bridge and 
also ethernet traffic is bridged into the mini-mesh setup I use correctly. 
Furthermore there are no ogm messages visible anymore at bat0 (with the 
command batctl td bat0).

Do you see a chance to add these changes to the compatibility code for 
older kernels (I guess for kernels < 2.6.39)?

Thanks for the excellent help,
Andreas

