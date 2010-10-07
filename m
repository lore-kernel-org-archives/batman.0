Return-Path: <mag@magwas.rulez.org>
Message-ID: <4CAD8DEB.2010407@magwas.rulez.org>
Date: Thu, 07 Oct 2010 11:07:55 +0200
From: =?UTF-8?B?TWFnb3PDoW55aSDDgXJww6Fk?= <mag@magwas.rulez.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [B.A.T.M.A.N.] Windows 7 and ad hoc network
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

  If it is an inappropriate place to post, please direct me to the right 
place.
I could not find relevant info with google.

I have an ad hoc network using batman. The network config of backbone nodes:
10.42.0.N/24 :wireless interface, network for backbone nodes
10.42.N.1/24 : wireless interface, network for user nodes. dhcp served here
10.43.N.1/24 : wired interface, network for user nodes. dhcp served here

This setup works with linux as a user node. It tries its old ip with 
dhcp request, but after that it asks for a new address with dhcp 
discover. But with a windows 7 there is a problem.
The windows gets an address with DHCP from one node. When it roams to 
another nodes' area, it cannot get an ip address for the new area. It 
seems that the windows box do not want to forget the first IP it got. We 
have tried:
ipconfig /renew
shutting down and restarting wifi connection
setting dhcp lease time to 1 min in all nodes, going to the old node 
area, getting the old ip, and renew, shut down, etc.

The windows seems to use dhcp request all times, never dhcp discover, 
even after it obviosly figured out that the old IP won't work.
The dhcp servers aren't set to be authoritative, as it would create 
problems where their area overlap.

I would be glad to have any suggestions.

Thank you
