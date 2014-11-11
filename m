Return-Path: <r.krishnathiepan@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20141111133816.GI799@odroid>
References: <CAEbDFcQwcri8gnmVYjMzX=gyTMmtSiQ_6Dzq1yeR+=UzTgYCTw@mail.gmail.com>
 <20141111133816.GI799@odroid>
Date: Tue, 11 Nov 2014 22:23:57 +0530
Message-ID: <CAEbDFcRguLETJdx3-emoTb0F87sQsoXGZ99JX62GqQ7PRgESxw@mail.gmail.com>
From: Krishnathiepan Rasanayagam <r.krishnathiepan@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [B.A.T.M.A.N.] tcp filtering in batman-adv
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

hi,

oh. No suspense :)
i am currently experimenting with QoS services which can be provided
by batman-adv, for that thinking about creating a queue inside send.c
with packet filtering. thats why i wanna know where to read the data.

best regards,
krishna

On Tue, Nov 11, 2014 at 7:08 PM, Linus L=C3=BCssing <linus.luessing@c0d3.bl=
ue> wrote:
> On Tue, Nov 11, 2014 at 05:19:19PM +0530, Krishnathiepan Rasanayagam wrot=
e:
>> Hi All,
>>
>> Had anyone of you have ever done tcp filtering in batman - adv.
>> I have started to code it in send.c file in batman code. Using skb_buff
>> But not getting any expected out puts.
>> Any one have any better solutions?
>
> To avoid continuing this guessing game - would you mind explaining
> a little what you want to achieve exactly in the end and why? I'm a
> little curious :). And maybe that'll help finding the easiest,
> most convinient way.
>
> Cheers, Linus



--=20
Best regards,
Krishna.
