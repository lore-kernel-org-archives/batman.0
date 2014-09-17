Return-Path: <zaki.bm@gmail.com>
MIME-Version: 1.0
In-Reply-To: <541938E5.8010701@meshcoding.com>
References: <CABQkniB+rTunkzArRbkfxp07zwj_CKP4_VysZkzUpzwPpGt2mw@mail.gmail.com>
 <541938E5.8010701@meshcoding.com>
Date: Wed, 17 Sep 2014 15:43:03 +0800
Message-ID: <CABQkniAWwbC9Gy_NjMt7OVgsxC2vN3cDcZ-3LAjx_v8kuraCQA@mail.gmail.com>
From: Zaki <zaki.bm@gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [B.A.T.M.A.N.] IBSS key in batman-adv
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
To: Antonio Quartulli <antonio@meshcoding.com>
Cc: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

Hi Antonio,

Thank you very much for your great support.  Ok, now it clear to me
that i need to troubleshoot on my IBSS setup rather than batman-adv.
I will check again my IBSS-RSN.

Rgds,
Zack.

On Wed, Sep 17, 2014 at 3:31 PM, Antonio Quartulli
<antonio@meshcoding.com> wrote:
> Hi Zaki,
>
> On 17/09/14 09:04, Zaki wrote:
>> Hi,
>>
>>
>> I have a short question.  I am using IBSS to create batman-adv mesh
>> network.  To secure the IBSS, i am using the IBSS key.  I noticed that
>> when i am on the mesh network, any device that is not having the key
>> also can ping and iperf to me.  I thought IBSS key is supposed to
>> allow only legitimate device.  Does anybody know where i do wrong
>> here?.
>
> This is more a linux-wireless question other than a batman-adv one.
> batman-adv itself can't do much in this case since it does not know
> anything about what is happening on the layers below.
>
> In my opinion you are doing something wrong while setting up the
> IBSS-RSN mechanism. (I guess you are using IBSS-RSN right ?)
>
> A station not having the correct key should show up in the "station
> dump" output of the other nodes with the "Authorized" attribute set to
> "no". Is this the case? If not, then something i wrong with the
> wpa_supplicant setup.
>
>
> Cheers,
>
> p.s. I'd recommend CC'ing the linux wireledd mailing list if you have
> further questions.
>
> --
> Antonio Quartulli
>
