Return-Path: <gmazzurco89@gmail.com>
Sender: Gioacchino Mazzurco <gmazzurco89@gmail.com>
Message-ID: <50CDC8CA.1020808@eigenlab.org>
Date: Sun, 16 Dec 2012 14:12:42 +0100
From: Gioacchino Mazzurco <gio@eigenlab.org>
MIME-Version: 1.0
References: <CA+Cq8Jfri-08__Bfj1b2S9otKaL5PqbvcdR7aHnnYV4HRjbACg@mail.gmail.com>
In-Reply-To: <CA+Cq8Jfri-08__Bfj1b2S9otKaL5PqbvcdR7aHnnYV4HRjbACg@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [B.A.T.M.A.N.] [RFC] batman-adv and babel hybrid status
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
Cc: Shubham Aher <shubham.aher@juggler.net>

On 12/16/12 12:30, Shubham Aher wrote:
>  Hello ecsv,
> 
> We had discussed the idea of running babel over batman-adv on the IRC
> Channel #batman.I am currently working on the same.I was curious about
> the commit https://github.com/jech/babeld/commit/8d4d2c9e763ae1e04a0fb3486b222ec8a3ce3b.Can
> you elaborate on what does it facilitate also what is present status
> of the same.
> 
> Regards,
> Shubham Aher
> 

It simply treat batman-adv interfaces like bat0 as wireless by default
