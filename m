Return-Path: <plettpc@gmail.com>
Message-ID: <4DB17A33.8080002@gmail.com>
Date: Fri, 22 Apr 2011 14:53:07 +0200
From: wayne <plettpc@gmail.com>
MIME-Version: 1.0
References: <BANLkTin=6SArq_5+n7SMRHfX2p-RGgsomA@mail.gmail.com>	<BANLkTikBcWdW==dP8BG4Ud5HjxyQ0z0n3A@mail.gmail.com>	<20110419132935.GA20312@Sellars>	<BANLkTi=iDC+oFgvX7DxqPhAv8gG1ftfkVw@mail.gmail.com>	<BANLkTi=TvyaGbMUBF5wZU=jh+uVm==BerQ@mail.gmail.com>	<20110421174352.GA23449@Sellars>
	<BANLkTinqqA5AR8pjU0PSyKJxUqZsRaQdZw@mail.gmail.com>
In-Reply-To: <BANLkTinqqA5AR8pjU0PSyKJxUqZsRaQdZw@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [B.A.T.M.A.N.] batman-adv vis_data
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

On 21/04/2011 19:47, Gioacchino Mazzurco wrote:
>> you didn't add
>> your bridge interface to batman, did you?
>
> Yes on Marek suggestion i done
> batctl if add br-clients
>
> instead of
> batctl if add eth0
>
> br-clients = bat0 + eth0 [ + ath0 eventually ]
>

Hi All

Firstly I want to thank all the devs here for the excellent work! I have 
recently upgraded all my Nodes here in Rural S.Africa as per VT project 
to B-ADV and it just works.

To Reply on setup question.

here is mine!
interfaces: eth0, wifi0( ath0,ath1)  UBNT unit.

root@MP-20:/etc/config# brctl show
bridge name	bridge id		STP enabled	interfaces
br-lan		8000.00094557a8e5	yes		eth0
							bat0
							ath1

root@MP-20:/etc/config# batctl if
ath0: active

As bat0 is already bridged with the other interfaces, it's only required 
to run Bat-adv on the mesh interface i.e ath0.
VAP: ath1 is used as a AP also link-local,with pppoe server all 
clients,node bridge ip's all static.

Wayne A





