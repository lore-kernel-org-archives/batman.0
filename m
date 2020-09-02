Return-Path: <b.a.t.m.a.n-bounces@lists.open-mesh.org>
Subject: Re: Node amount restriction in IEEE 802.11s mesh network
References: <CADSehqPK2R0ymqwFFm-wcE1m+K8WoAYSb1dwiCNhaNQDP6xYEw@mail.gmail.com>
From: Moritz Warning <moritzwarning@web.de>
Message-ID: <69c4adcb-ba52-d8f7-855b-ccf148ab0af7@web.de>
Date: Wed, 2 Sep 2020 19:19:33 +0200
MIME-Version: 1.0
In-Reply-To: <CADSehqPK2R0ymqwFFm-wcE1m+K8WoAYSb1dwiCNhaNQDP6xYEw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n.lists.open-mesh.org>
List-Archive: <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>
To: b.a.t.m.a.n@lists.open-mesh.org

On 9/2/20 5:08 PM, Maksim Iushchenko wrote:
> I read that IEEE 802.11s mesh network has a restriction for how many
> nodes it consists of. It is supposed that the number of nodes in IEEE
> 802.11s mesh network does not exceed 32 nodes or so.
>
> Is it HWMP protocol restriction? Or what is it related to? If I turn
> HWMP off and use batman-adv instead, could it overcome such
> restriction?
>
Yes. If you disable meshing for 802.11s, then batman-adv can use the MAC l=
ayer and use its own routing algorithm, which does not have this limitatio=
n.
