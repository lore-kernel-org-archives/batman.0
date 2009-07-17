Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Sat, 18 Jul 2009 02:53:03 +0800
References: <1739bfe0907150649l61d6b0dga6825e84dc45832d@mail.gmail.com>
	<200907161900.54293.lindner_marek@yahoo.de>
	<1739bfe0907170010n67ae2bd8m9bf9813d09687951@mail.gmail.com>
In-Reply-To: <1739bfe0907170010n67ae2bd8m9bf9813d09687951@mail.gmail.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200907180253.03945.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [vis] fixed partial json output
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.net>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.net>
List-Unsubscribe: <https://lists.open-mesh.net/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.net/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.net>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=help>
List-Subscribe: <https://lists.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.net>

On Friday 17 July 2009 15:10:55 jonathan mzengeza wrote:
> I looked at the site and it talked about something I had already tried
> which works well. Here is another patch hope its better.
>
> +	shutdown(thread_data->socket, SHUT_WR);

Does your patch also work without the shutdown ? Some clients (e.g. s3d) read 
the constant stream of vis data to update their visualization without  re-
opening the connection. 

Regards,
Marek

