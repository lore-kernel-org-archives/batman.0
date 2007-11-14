Message-ID: <473B1D95.6090907@leipzig.freifunk.net>
Date: Wed, 14 Nov 2007 17:08:53 +0100
From: tetzlav <tetzlav@leipzig.freifunk.net>
MIME-Version: 1.0
Subject: Re: AW: [B.A.T.M.A.N.] wrong ip rules
References: <470056.58415.qm@web26904.mail.ukl.yahoo.com>
	<9D5AAFCD-D6EB-4F3B-986E-BBB5F36E7218@lo-res.org>
In-Reply-To: <9D5AAFCD-D6EB-4F3B-986E-BBB5F36E7218@lo-res.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
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

Aaron Kaplan schrieb:
> On Nov 14, 2007, at 8:30 AM, Marek Lindner wrote:
>
>> Why does batmand not recognize OLSR interfaces and
>> ignores them ? We simply could not find a good solution for
>> this kind of detection but we are open to suggestions.  ;-)
>
>
> parse /etc/olsrd.conf? 

This is dirty and not generic enough.
Batmand is IP-based/layer3, so why not bind batmand to IPs (optional)
instead of interfaces!?
(like olsrd)


my 0,02€
tetzlav
