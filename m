Return-Path: <ipmax2011@googlemail.com>
MIME-Version: 1.0
In-Reply-To: <201107041455.33023.lindner_marek@yahoo.de>
References: <CAJA-1Lijvt9hZVTP0QXi81bk061A54tRs=quUyztzo2_cM-LNw@mail.gmail.com>
	<201107041455.33023.lindner_marek@yahoo.de>
Date: Mon, 4 Jul 2011 18:06:19 +0200
Message-ID: <CAJA-1Ljmeqym_Sj4zqSEqaJtVvGf3brFQPtghYYi2QT5PFLYHw@mail.gmail.com>
From: Max Ip <ipmax2011@googlemail.com>
Content-Type: text/plain; charset=ISO-8859-1
Subject: Re: [B.A.T.M.A.N.] Disconnecting the nodes in batman-adv 2011.1.0
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
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

Hi all,

This is something to be posted in other forums. But just wanted to
know if you faced the same problem.

I tried to drop the connections between the end users (node_1 and node_3) of

node_1 ----node_2-----node_3


iptables -t raw -A PREROUTING -i wlan0 -m mac --mac-source
00:13:a9:c3:ae:8f -j DROP


but the protocol still doesn't show the two hop environment.




On Mon, Jul 4, 2011 at 2:55 PM, Marek Lindner <lindner_marek@yahoo.de> wrote:
> On Monday, July 04, 2011 14:45:57 Max Ip wrote:
>> sudo iptables -A INPUT -s 10.42.43.3 -j DROP
>>
>> When, I now run batman-adv protocol, node_1 still finds node_3 without
>> node_2 being involved.
>>
>> Though they cannot ping and avahi doesn't run, batman-adv shows them
>> as 1 hop neighbors.
>>
>> How can I disconnect node_1 from node_3 so that I can see the 2 hop
>> patterns.
>
> batman-adv operates on layer 2 - the mac address layer. IP addresses are
> irrelevant for the mesh to work. You can remove all IP addresses and the nodes
> still find each other (try batctl ping or batctl traceroute when you have no
> IP addresses configured). Therefore blocking the IP traffic does not interrupt
> anything. You'd have to block mac addresses via ebtables or similar tools.
>
> Regards,
> Marek
>
