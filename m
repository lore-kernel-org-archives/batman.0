Return-Path: <gmazzurco89@gmail.com>
MIME-Version: 1.0
In-Reply-To: <201104161122.16517.lindner_marek@yahoo.de>
References: <201104161122.16517.lindner_marek@yahoo.de>
Date: Sat, 16 Apr 2011 11:42:29 +0200
Message-ID: <BANLkTikZ1O3J8UAuomQmKVH1c=3NAAhY7A@mail.gmail.com>
From: Gioacchino Mazzurco <gmazzurco89@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Subject: Re: [B.A.T.M.A.N.] Batman-adv hna balancing
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
Cc: Marek Lindner <lindner_marek@yahoo.de>

ok understood

many thanks!

2011/4/16 Marek Lindner <lindner_marek@yahoo.de>:
>
> Hi,
>
>> Here you can see our topology, there is two nodes at moment they are
>> connected to the same switch and should see same hnas but they are
>> announced mostly by one of the two
>> http://eigenlab.org/batman-adv_status.php
>>
>> If i turn off the cc:c8 node the hna pass to the other nodes but when
>> i turn it on all hna pass on it
>>
>> Why this? Is not better to balance hna announcing?
>
> the 2 batman-adv nodes probably detected they are connected to the same switch
> and activated the bridge loop avoidance [1]. With 'batctl sn' you can retrieve
> the bridge loop neighbor list.
>
> Regards,
> Marek
>
>
> [1] http://www.open-mesh.org/wiki/batman-adv/Bridge-loop-avoidance
>
