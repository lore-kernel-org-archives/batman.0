From: Marek Lindner <lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] 0.3 final <-> quagga
Date: Thu, 8 May 2008 18:12:33 +0800
References: <51B22798-78A8-4425-BAEA-530297B1518A@cslab.ece.ntua.gr>
	<200805081723.37648.lindner_marek@yahoo.de>
	<4822C548.40603@leo34.net>
In-Reply-To: <4822C548.40603@leo34.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200805081812.33117.lindner_marek@yahoo.de>
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
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
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@open-mesh.net>


> Its a batman plugin like an olsr plugin. zebra doesnt provide any
> plugins imo.
>
> You provide a external switch to insert HNA by script. Unfortunately,
> zebra cant call external script as i have to patch zebra then - or i
> dont know how.
>
> with the olsr-quagga-plugin i can redistribute zebra routes to olsr
> internally. thats something i like to see with batman-zebra-plugin.

Batman does not provide any plugin interface as well. Simply because it is a 
routing daemon and should only do that. On the other hand we don't like this 
rewriting of plugins over and over again.
As already explained in the other part of this thread batman offers an 
external interface for adding/deleting routing information which could be 
used for that. A little external application can talk to zebra, add/delete 
routes and/or HNA and could be _reused_ by other routing applications.

Greetings,
Marek



