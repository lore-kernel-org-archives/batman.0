Return-Path: <r.krishnathiepan@gmail.com>
MIME-Version: 1.0
In-Reply-To: <5463259B.2020704@meshcoding.com>
References: <CAEbDFcQegtyVxsHUYjF5NL8mrL62LdkQNWtNikLtscodsGG1Ow@mail.gmail.com>
 <5463259B.2020704@meshcoding.com>
Date: Wed, 12 Nov 2014 17:21:28 +0530
Message-ID: <CAEbDFcQfXiiTDiuz_nEjxqfC5bJ1vbUM_vmo1=QWuvxUUhHnuQ@mail.gmail.com>
From: Krishnathiepan Rasanayagam <r.krishnathiepan@gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [B.A.T.M.A.N.] Threads in batman-adv
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

yep. i should have :)
now only freading it out. sorry

thanks alot for replying :)

On Wed, Nov 12, 2014 at 2:47 PM, Antonio Quartulli
<antonio@meshcoding.com> wrote:
>
>
> On 12/11/14 09:19, Krishnathiepan Rasanayagam wrote:
>> Hi All,
>>
>> Has anyone considered using threads in batman-adv?
>
> did you mean kthread? I don't think this would bring any real benefit.
> You should probably read/understand the rest of the networking stack in
> the linux kernel to understand how incoming/outgoing packets are handled.
>
>> is is possible to use fork() send.c file?
>
> fork() is a function that is supposed to be used in *userspace* to
> create a new *process*.
> This is neither available nor conceptually possible in kernel space.
>
> Maybe you should read a bit more about what you can do and what you
> cannot do while developing a kernel module? :)
>
> --
> Antonio Quartulli
>



-- 
Best regards,
Krishna.
