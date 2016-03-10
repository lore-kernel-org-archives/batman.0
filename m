Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Thu, 10 Mar 2016 20:37:20 +0100
Message-ID: <14018446.sYtkVuqokJ@bentobox>
In-Reply-To: <b01d3ee936833e94fffa53f7a82fc46e20d877c1.1450451516.git.geliangtang@163.com>
References: <ab66a344512e064000357c6d3c2a6f3d0e948ddb.1450451516.git.geliangtang@163.com>
 <b01d3ee936833e94fffa53f7a82fc46e20d877c1.1450451516.git.geliangtang@163.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1742115.cVfNBIK0Ea";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH 07/14] batman-adv: use
	list_for_each_entry_safe
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Geliang Tang <geliangtang@163.com>, Antonio Quartulli <a@unstable.cc>, Marek Lindner <mareklindner@neomailbox.ch>

--nextPart1742115.cVfNBIK0Ea
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Friday 18 December 2015 23:33:31 Geliang Tang wrote:
> Use list_for_each_entry_safe() instead of list_for_each_safe() to
> simplify the code.
> 
> Signed-off-by: Geliang Tang <geliangtang@163.com>
> ---
>  net/batman-adv/icmp_socket.c | 22 +++++++++-------------
>  1 file changed, 9 insertions(+), 13 deletions(-)

Reviewed-by: Sven Eckelmann <sven@narfation.org>

Kind regards,
	Sven

> 
> diff --git a/net/batman-adv/icmp_socket.c b/net/batman-adv/icmp_socket.c
> index bcabb5e..841239c 100644
> --- a/net/batman-adv/icmp_socket.c
> +++ b/net/batman-adv/icmp_socket.c
> @@ -104,25 +104,21 @@ static int batadv_socket_open(struct inode *inode, struct file *file)
>  
>  static int batadv_socket_release(struct inode *inode, struct file *file)
>  {
> -	struct batadv_socket_client *socket_client = file->private_data;
> -	struct batadv_socket_packet *socket_packet;
> -	struct list_head *list_pos, *list_pos_tmp;
> +	struct batadv_socket_client *client = file->private_data;
> +	struct batadv_socket_packet *packet, *tmp;
>  
> -	spin_lock_bh(&socket_client->lock);
> +	spin_lock_bh(&client->lock);
>  
>  	/* for all packets in the queue ... */
> -	list_for_each_safe(list_pos, list_pos_tmp, &socket_client->queue_list) {
> -		socket_packet = list_entry(list_pos,
> -					   struct batadv_socket_packet, list);
> -
> -		list_del(list_pos);
> -		kfree(socket_packet);
> +	list_for_each_entry_safe(packet, tmp, &client->queue_list, list) {
> +		list_del(&packet->list);
> +		kfree(packet);
>  	}
>  
> -	batadv_socket_client_hash[socket_client->index] = NULL;
> -	spin_unlock_bh(&socket_client->lock);
> +	batadv_socket_client_hash[client->index] = NULL;
> +	spin_unlock_bh(&client->lock);
>  
> -	kfree(socket_client);
> +	kfree(client);
>  	module_put(THIS_MODULE);
>  
>  	return 0;
> 

--nextPart1742115.cVfNBIK0Ea
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJW4czwAAoJEF2HCgfBJntG+pwP/jg87WvOsdphIQnCSBoPTNp1
uWdeyS5JhphXdIkbVU2G+cPZMBo/KPJR3+7yBL/Tq0TmUaJDwy20SpioBetSGWO0
11Y2ohVyjmRwE3zpTI/gPMCpnfv8sT+lsqkX+FavjKnlMPYNJVQup3Tev9hd7iiq
yt3MB5dPBQfs/N16+6gxeGf1LjwuiOLQ6MAMZxqiRYHv7uzdSwEd9v8nWeTew5G2
DbwmtHzD88MBBMB6FmkX1BTkoUxjB+GfhevBUMJSBpg0MbGMU7Kr4SxA9TOd6UE6
mlqzh12nKuPMkr+RqT7aIPwmAEC2ISrExAo9KZtdtKGmbpzF32fx576LiXx5dc/r
Ajtf22BefKQr+xsLbxEVCl4PoOdMOGWVvNl8xRUaGuuKHVFrx3hYkN0F2XQn0F51
T0mecOBCV0saGszY05LeyeV9QiiU4VqM013pn5rw5AMPc4+8D0kbz6EQzOT54Iff
OS90Q2o3pv2DgDdiGHFOJAxmIRXPifpZHW4+K1lmE5ai7OKBqDbbKEO23eWdscCL
TG7F+v5do+MTS2h5N/V6cfvR29QUWBXt0tuvDCmpcBIy3hW7wDQd9ITft2iYeAR5
znMFe5R6maJ9VdklKfeJ4W0bKV2iNIiRSvuyAM4wKvyRKk6cmS9RL4/D5vwah/YF
RcItIxrk2ziMFBS4QYfZ
=TiIa
-----END PGP SIGNATURE-----

--nextPart1742115.cVfNBIK0Ea--

