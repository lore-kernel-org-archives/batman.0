Return-Path: <carocci.eugenio@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20130918061901.GF3053@neomailbox.net>
References: <CADtP98UYNT7KOg9a1Pc+bozarwxfpNh8E+BG14xbvGX5EQsFVA@mail.gmail.com>
 <20130918061901.GF3053@neomailbox.net>
Date: Wed, 18 Sep 2013 10:16:51 +0200
Message-ID: <CADtP98XqeKBw=T8__wbOprKUVkreAZGhPyrYuCcerYJj5zLuKQ@mail.gmail.com>
From: Eugenio Carocci <carocci.eugenio@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Subject: Re: [B.A.T.M.A.N.] Where can i see, sequence number, eq,
	rq for an originator?
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

Thanks you for the reply, just one last question. Is there some paper
online that explain, how the protocol
avoid routing loop, may with some examples? :)

2013/9/18 Antonio Quartulli <antonio@meshcoding.com>:
> Hello Eugenio,
>
> On Wed, Sep 18, 2013 at 12:55:27AM +0200, Eugenio Carocci wrote:
>> Hello everybody,
>>
>> first of all, i want to excuse myself, if i write something wrong for
>> my horrible english. I am writing my thesis of Information Engineering
>> about your protocol.
>
> It's not only ours, but it's everybody's protocol ;-)
>
>> So, as i wrote in the object of the
>> message, i want to see where BATMAN-adv save the last sequence number
>> saved for a generic originator, and also
>> where it puts all the information act to evaluate the TQ toward each
>> originator of the mesh.
>>
>
> The information exported to the user are visible through the originator table
> (batctl can help you getting that), but most of the things you were asking for
> (I'm reading the subject of the email..)are not exported at all.
>
> This means you can't see those values from a user prospective.
> You would need to patch the code and print them manually (if you are really
> interested in that..).
> For this you may want to have a look at the "neigh_node" structure.
>
>
>
>
> Cheers,
>
> --
> Antonio Quartulli



-- 
Eugenio Carocci
