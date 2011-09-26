Return-Path: <laurent@wifibot.com>
Message-ID: <4E80EB52.2010906@wifibot.com>
Date: Mon, 26 Sep 2011 23:14:58 +0200
From: laurent <laurent@wifibot.com>
MIME-Version: 1.0
References: <4E80E977.8090608@wifibot.com>
In-Reply-To: <4E80E977.8090608@wifibot.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [B.A.T.M.A.N.] batman-adv 2011.2.0 hop somtimes does not work
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: b.a.t.m.a.n@lists.open-mesh.org, Antonio Quartulli <ordex@autistici.org>

in fact I made a mistake:

ping from 192.168.1.105 for 192.168.1.103 not working
ping from 192.168.1.105 for 192.168.1.102 not working
ping from 192.168.1.102 for 192.168.1.103 not working

but ping from 192.168.1.101 for 192.168.1.103 working
and ping from 192.168.1.101 for 192.168.1.102  working

192.168.1.101 is another that is not involved on the traceroute to reach  00:15:6d:a3:15:2e (192.168.1.103)

 traceroute to 00:15:6d:a3:15:2e (00:15:6d:a3:15:2e), 50 hops max, 20 byte packets

 1: 00:15:6d:ad:d3:2b  0.563 ms  1.045 ms  1.115 ms
 2: 00:15:6d:a3:15:2e  2.522 ms  2.142 ms  2.153 ms
 
