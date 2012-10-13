Return-Path: <nicoechaniz@altermundi.net>
Message-ID: <5079421E.9000103@altermundi.net>
Date: Sat, 13 Oct 2012 07:27:42 -0300
From: =?UTF-8?B?Tmljb0VjaMOhbml6?= <nicoechaniz@altermundi.net>
MIME-Version: 1.0
References: <507798EE.80305@codigosur.org> <50779CA3.9070208@yahoo.de>
 <5077A77B.3040803@altermundi.net> <20121012071559.GB2564@ritirata.org>
 <5078131D.9070508@altermundi.net> <20121012130457.GA4566@ritirata.org>
In-Reply-To: <20121012130457.GA4566@ritirata.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [B.A.T.M.A.N.] batman-adv: ap mode with isolation enabled
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

On 10/12/12 10:04, Antonio Quartulli wrote:
> On Fri, Oct 12, 2012 at 09:54:53AM -0300, NicoEchániz wrote:
>> On 10/12/12 04:15, Antonio Quartulli wrote:

> If you use infrastructure mode without AP isolation, batman-adv will consider
> all the other STAs as direct neighbours. But, due to infrastructure mode,
> packets from STA1 to STA2 will always pass through the AP. This is also why I
> would suggest to keep AP-isolation ON if you want to run batman-adv on the
> stations and on the AP, but then it depends on what you want to get.

Well that was my conclusion, but as I didn't find this "problem"
mentioned anywhere I thought I'd share on the list. It's good to know
that this is your suggestion also. Maybe it would be worth mentioning
this somewhere in the Wiki, for others with a similar setup.


cheers

