Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Tue, 16 Mar 2010 12:38:09 +0800
References: <8D692389-52C5-4CCB-BE58-D4B2E4D07161@me.com>
	<201003151944.27711.lindner_marek@yahoo.de>
	<67B8674E-E8BB-4EE6-B368-F28AA0C957AB@me.com>
In-Reply-To: <67B8674E-E8BB-4EE6-B368-F28AA0C957AB@me.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <201003161238.09704.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] B.A.T.M.A.N Suitability for MAGIC 2010
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


Hi,

> With regards to the type of middleware that I am searching for. Well,  
> pub/sub with reliable and unreliable QoS is what we will most likely  
> be using. I don't want to rush into a solution that buries the network  
> in traffic from inter-broker communication, nor do I want to choose a  
> middleware that fails in ad-hoc type networks. In any case, the  
> middleware must hold up against repeated network partitioning and  
> merging.

I'm not aware of any software which was specifically designed to operate over a 
mesh network (apart from mesh routing daemons of course). Everybody simply 
uses normal network operations and lets the lower layers handle the magic. 
Therefore they are all equally "bad" (unless someone can name a positive 
example)  :-).
If you are interested in QoS you should make use of the wifi's QoS as Linus 
suggested.


> If we do use B.A.T.M.A.N we will likely be using the layer-2 flavor  
> running on a router with openWRT. So drivers will not be an issue,  
> just router selection.

Ok.

Cheers,
Marek
