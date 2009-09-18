Return-Path: <lick.prize@gmail.com>
Message-ID: <B32C944A35244A19A20707D36198AFEE@youillmlpt3>
From: "Lick A Prize" <lick.prize@gmail.com>
References: <AACE951F705644649DB6ABC24CFBCF29@youillmlpt3><8c906fa50909171115v2b296844h69c5f93eea99403c@mail.gmail.com>
	<4AB28C2D.7060600@tiwoc.de>
In-Reply-To: <4AB28C2D.7060600@tiwoc.de>
Date: Fri, 18 Sep 2009 14:38:53 +1000
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
Subject: Re: [B.A.T.M.A.N.] IP from MAC
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.net>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.net>
List-Unsubscribe: <https://lists.open-mesh.net/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.net/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.net>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=help>
List-Subscribe: <https://lists.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.net>

OK so IPs from MAC addresses is pretty good but not a perfect solution.

This comment is interesting...

> However, as Marek already wrote, the focus of the batman development
> moves to layer 2 where IP addresses are not used. On top of batman-adv,
> you can use any IP address distribution scheme you like. For example,
> you could simply run a DHCP server.
>
> Regards,
> Daniel

Batman-adv does indeed seem like the way forward. So, on top of batman-adv, 
what solutions are there for IP address distribution? What might you try in 
a situation where there is no obvious central coordinator to put a DHCP 
server on? 

